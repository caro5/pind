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
@synthesize selectedLoc, geoDict, imageView, image;

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
    [addPin setTitle:@"Add" forState:UIControlStateNormal];
    imageView.hidden = YES;
    searchBar.showsCancelButton = NO;
    
    
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

    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    searchBar = [[UISearchBar alloc] init];
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [searchBar sizeToFit];
    UIView *barWrapper = [[UIView alloc]initWithFrame:searchBar.bounds];
    [barWrapper addSubview:searchBar];
    searchBar.placeholder = @"enter a place";
    searchBar.delegate = self;
    
    [self.searchDisplayController setActive: YES animated: YES];
    [self.searchDisplayController.searchBar becomeFirstResponder];
    
    searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.navigationItem.titleView = searchDC.searchBar;
    
    searchDC.delegate = self;
    //    searchDC.searchResultsDataSource = searchTable.dataSource;
    //    searchDC.searchResultsDelegate = searchTable.delegate;
    // searchTable.tableHeaderView = searchBar;
    //
    //
    
    addPin = [[UIButton alloc] initWithFrame:CGRectMake(20, 70, 50, 30)];
    addPin.backgroundColor = [UIColor grayColor];
    [addPin addTarget:self action:@selector(addPin:) forControlEvents:UIControlEventTouchUpInside];
    [addPin setTitle:@"Add" forState:UIControlStateNormal];
    
    //addSubviews
    [self.view addSubview:map];
    [self.view addSubview:addPin];
    [self.view addSubview:searchTable];
    
    //select location: target image frame
    CGRect frame;
    frame.origin.x = [[UIScreen mainScreen] bounds].size.width/2-60;
    frame.origin.y = [[UIScreen mainScreen] bounds].size.height/2-50;
    frame.size = CGSizeMake(120,100);
    image = [UIImage imageNamed:@"target.png"];
    imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setCenter:CGPointMake(CGRectGetMidX([[UIScreen mainScreen] bounds]), CGRectGetMidY([[UIScreen mainScreen] bounds]))];
    [self.view addSubview:imageView];
    imageView.frame = frame;
    
    map.delegate = self;
    [map setShowsUserLocation:YES];
    locManager = [[CLLocationManager alloc] init];
    [locManager setDelegate:self];
    
    [locManager setDistanceFilter:kCLDistanceFilterNone];
    [locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [locManager startUpdatingLocation];
    
}

- (void) searchBarTextDidBeginEditing: (UISearchBar*) aSearchBar {
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton: YES animated: YES];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)aSearchBar
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClicked:)];
    [self.navigationItem setRightBarButtonItem:cancelButton animated:YES];
    
    return YES;
}

-(void)cancelClicked:(id)sender
{
    searchBar.text = @"";
    searchBar.placeholder = @"enter a place";
    [self searchBarCancelButtonClicked:self.searchBar];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar
{
    [searchBar resignFirstResponder];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
    searchTable.hidden = YES;
    for (id<MKAnnotation> annotation in map.annotations) {
        
        [map removeAnnotation:annotation];
    }
    [self showLocArrayPins];
}
-(void) showLocArrayPins {
    for (Location*  locn in [LocArray sharedInstance].locArray) {
        PinAnnot *pin = [[PinAnnot alloc] initWithCoordinates:locn->coordinate placeName: locn.title description:locn.address];
        pin.title = locn->title;
        pin.subtitle = locn.address;
        pin.color = @"green";
        [map addAnnotation:pin];
    }
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
        EditAddPinViewController *edAddVC = [[EditAddPinViewController alloc] init];
        UINavigationController * navVC = [[UINavigationController alloc] init];
        [navVC pushViewController:edAddVC animated:NO];
        [Location sharedInstance]->loc = selectedLoc;
        [Location sharedInstance]->coordinate = selectedLoc.coordinate;
        NSString* addrcit = [NSString stringWithFormat:@"%@, %@", self.address, self.city];
        edAddVC.locQueryAddr = addrcit;
        [self presentViewController:navVC animated:YES completion:nil];
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
    NSString* addrcit = [NSString stringWithFormat:@"%@, %@", self.address, self.city];
    edAddVC.locQueryAddr = addrcit;
    [self presentViewController:navVC animated:YES completion:nil];
    
}

-(void) setLoc {
    [addPin setTitle:@"Save" forState:UIControlStateNormal];
    imageView.hidden = NO;
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.selectedLoc = [[CLLocation alloc] initWithLatitude:mapView.centerCoordinate.latitude
                                                  longitude:mapView.centerCoordinate.longitude];
    [self performSelector:@selector(reverseGeoCode)
               withObject:nil
               afterDelay:0.3];
}

-(void) reverseGeoCode {
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:self.selectedLoc completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count]) {
            NSDictionary* dict = [[placemarks objectAtIndex:0] addressDictionary];
            self.address = [dict valueForKey:@"Street"];
            self.city = [dict valueForKey:@"City"];
            self.state = [dict valueForKey:@"State"];
            self.zip = [dict valueForKey:@"ZIP"];
            NSLog(@"reverse:%@, %@, %@", self.address, self.city, self.state);
        } else {
            NSLog(@"Error in reverseGeoCode");
        }
    }];
    
}
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MKCoordinateRegion region;
    
    //change the 500 when doing filter
    region = MKCoordinateRegionMakeWithDistance(locManager.location.coordinate,500, 500);

    [mapView setRegion:region animated:NO];
    
}
-(void)makeQuery
{
    double lat = currLoc.coordinate.latitude;
    double lon = currLoc.coordinate.longitude;
    
    NSString* query = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=5000000&keyword=%@&sensor=false&key=YOURKEY", lat,lon, searchTerm];
    
    //autocomplete query test
    // NSString* query = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?sensor=true&input=%@&key=YOURKEY", searchTerm];
    
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
