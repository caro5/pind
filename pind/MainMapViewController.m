//
//  MainMapViewController.m
//  pind
//
//  Created by Caroline Wong on 2/19/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "MainMapViewController.h"
#import "Location.h"
#import "LocArray.h"
#import "PinAnnot.h"
#import "EditAddPinViewController.h"
#import "AFNetworking.h"

@interface MainMapViewController () {
    Location* loc;
}

@end

@implementation MainMapViewController
@synthesize map, addPin, searchWords, searchBar, searchTable, searchResults;
@synthesize placesArray, searchTerm, currLoc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"103-map.png"];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [self.view reloadInputViews];
    [map removeAnnotations:map.annotations];
    
    for (Location*  locn in [LocArray sharedInstance].locArray) {
        PinAnnot *pin = [[PinAnnot alloc] initWithCoordinates:locn->coordinate placeName: locn.title description:locn.address];
        pin.title = locn->title;
        pin.subtitle = locn.address;
        pin.color = @"green";
        [map addAnnotation:pin];
        
    }
    searchTable.hidden = YES;
    searchBar.text = @"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view reloadInputViews];
    
    map = [[MKMapView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0,64,[[UIScreen mainScreen] bounds].size.width, 100)];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.hidden = YES;
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    searchBar.placeholder = @"enter place";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    //    [self.view addGestureRecognizer:tap];
    
    for (UIView *view in self.searchBar.subviews)
    {
        if ([view isKindOfClass: [UITextField class]]) {
            UITextField *tf = (UITextField *)view;
            tf.delegate = self;
            tf.tag = 1000;
            break;
        }
    }
    //  [self.view addSubview:searchBar];
    //    searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    //
    //  searchDC.delegate = self;
    //    searchDC.searchResultsDataSource = searchTable.dataSource;
    //    searchDC.searchResultsDelegate = searchTable.delegate;
    // searchTable.tableHeaderView = searchBar;
    // [self.view addSubview:searchDC];
    //
    
    addPin = [[UIButton alloc] initWithFrame:CGRectMake(20, 70, 50, 30)];
    addPin.backgroundColor = [UIColor grayColor];
    [addPin addTarget:self action:@selector(addPin:) forControlEvents:UIControlEventTouchUpInside];
    [addPin setTitle:@"Add" forState:UIControlStateNormal];
    
    //addSubviews
    [self.view addSubview:map];
    [self.view addSubview:addPin];
    [self.view addSubview:searchTable];
    
    // Do any additional setup after loading the view.
    
    map.delegate = self;
    [map setShowsUserLocation:YES];
    locManager = [[CLLocationManager alloc] init];
    [locManager setDelegate:self];
    
    [locManager setDistanceFilter:kCLDistanceFilterNone];
    [locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [locManager startUpdatingLocation];
    
}

//fix what happens when searchBar cancel clicked
-(void)dismissKeyboard {
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar {
	[aSearchBar resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self performSelector:@selector(searchBarCancelButtonClicked:) withObject:self.searchBar afterDelay: 0.1];
    return YES;
}

-(void)plotPositions:(NSArray *)data {
    for (id<MKAnnotation> annotation in map.annotations) {
        if ([annotation isKindOfClass:[Location class]]) {
            [map removeAnnotation:annotation];
        }
    }
    for (int i=0; i<[data count]; i++) {
        NSDictionary* placeDicts = [data objectAtIndex:i];
        NSString* name=[placeDicts objectForKey:@"name"];
        NSString* vicinity=[placeDicts objectForKey:@"vicinity"];
        
        CLLocationCoordinate2D placeCoord;
        placeCoord.latitude = [[[[placeDicts objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lat"] doubleValue];
        placeCoord.longitude= [[[[placeDicts objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lng"] doubleValue];
        
        PinAnnot* pin = [[PinAnnot alloc] initWithCoordinates:placeCoord placeName:name description:vicinity];
        pin.title = name;
        pin.subtitle = vicinity;
        
        [map addAnnotation: pin];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"PinAnnot";
    if ([annotation isKindOfClass:[PinAnnot class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        PinAnnot* a = annotation;
        if ([a.color isEqualToString:@"green"]) {
            annotationView.pinColor = MKPinAnnotationColorGreen;
        } else {
            annotationView.pinColor = MKPinAnnotationColorPurple;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        return annotationView;
    }
    return nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)sBar {
    sBar = searchBar;
    [map removeAnnotations:map.annotations];
    [sBar resignFirstResponder];
    currLoc = locManager.location;
    NSString *newString = [ @"%@", [sBar text] stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    searchTerm = newString;
    [self makeQuery];
    searchTable.hidden = NO;
}

- (void)addPin:(id)sender {
    if ([addPin.titleLabel.text isEqualToString:@"Add"]) {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles: @"add current location", @"set a location", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
    } else if ([addPin.titleLabel.text isEqualToString:@"Save"]) {
        NSLog(@"save the location in the middle of the target");
    }
    
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self savingCurrentLoc];
                    break;
                case 1:
                    [self setLoc];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}


-(void) savingCurrentLoc {
    EditAddPinViewController *edAddVC = [[EditAddPinViewController alloc] init];
    UINavigationController * navVC = [[UINavigationController alloc] init];
    [navVC pushViewController:edAddVC animated:NO];
    [Location sharedInstance]->loc = locManager.location;
    [Location sharedInstance]->coordinate = locManager.location.coordinate;
    [self presentViewController:navVC animated:YES completion:nil];
    
}

-(void) setLoc {
    [addPin setTitle:@"Save" forState:UIControlStateNormal];
    CGRect frame;
   // origin.x + ( size.width / 2 ) and origin.y + ( size.height / 2 )
    frame.origin.x = [[UIScreen mainScreen] bounds].size.width/2-60;
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height/2-50;
    frame.size = CGSizeMake(120,100);
    
    UIImage *image = [UIImage imageNamed:@"target.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    imageView.frame = frame;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MKCoordinateRegion region;
    
    //change the 2000 when doing filter
    region = MKCoordinateRegionMakeWithDistance(locManager.location.coordinate,2000, 2000);
    [mapView setRegion:region animated:NO];
    
}
-(void)makeQuery
{
    double lat = currLoc.coordinate.latitude;
    double lon = currLoc.coordinate.longitude;
    
    NSString* query = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=500&keyword=%@&sensor=false&key=yourkey", lat,lon, searchTerm];
    
    //autocomplete query test
    // NSString* query = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?sensor=true&input=%@&key=AIzaSyDUpFeJLCoR6mMZgcqwN23ZI5eJ67sQvio", searchTerm];
    
    NSURL* url = [NSURL URLWithString:query];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.placesArray = [responseObject objectForKey:@"results"];
        [self plotPositions:placesArray];
        
      //  NSLog(@"The Array: %@",self.placesArray);
        [searchTable reloadData];
        if ([placesArray count] == 0) {
            searchBar.text = @"no results found";
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    [operation start];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.placesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addButton addTarget:self action:@selector(addButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accessoryView = addButton;
    }
    
    NSDictionary *placeDict= [self.placesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [placeDict objectForKey:@"name"];
    
    if ([placeDict objectForKey:@"vicinity"] != NULL) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[placeDict objectForKey:@"vicinity"]];
    } else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"No Address"];
    }
    return cell;
}

- (void)addButtonTapped:(id)sender event:(id)event{
    NSSet* allTouch = [event allTouches];
    UITouch* touch = [allTouch anyObject];
    CGPoint currTPos = [touch locationInView:self.searchTable];
    NSIndexPath* indexPath = [self.searchTable indexPathForRowAtPoint:currTPos];
    if (indexPath != nil) {
        [self tableView: self.searchTable accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    EditAddPinViewController *edAddVC = [[EditAddPinViewController alloc] init];
    UINavigationController * navVC = [[UINavigationController alloc] init];
    NSDictionary *placeDicts= [self.placesArray objectAtIndex:indexPath.row];
    
    [Location sharedInstance]->coordinate.latitude = [[[[placeDicts objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lat"] doubleValue];
    [Location sharedInstance]->coordinate.longitude = [[[[placeDicts objectForKey:@"geometry"] objectForKey:@"location"] valueForKey:@"lng"] doubleValue];
    
    edAddVC.locQueryName = [placeDicts objectForKey:@"name"];
    edAddVC.locQueryAddr = [placeDicts objectForKey:@"vicinity"];
    [navVC pushViewController:edAddVC animated:NO];
    [self presentViewController:navVC animated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    for(int i = 0; i < [map.annotations count]; i++)
    {
        if ([[[map.annotations objectAtIndex:i] subtitle] isEqualToString:[[placesArray objectAtIndex:indexPath.row] objectForKey:@"vicinity"]]) {
            [map selectAnnotation:[map.annotations objectAtIndex:i] animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
