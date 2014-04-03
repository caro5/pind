//
//  LocProfViewController.m
//  pind
//
//  Created by Caroline Wong on 3/3/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "LocProfViewController.h"
#import "Tag.h"
#import "PinAnnot.h"

@interface LocProfViewController ()

@end

@implementation LocProfViewController
@synthesize noteLabel, noteString, noteWords, tagLabel, tagString, tagTitle, nameTitle, locationName, theLoc, map;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = theLoc.title;
    
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 180)];
    
    noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 60, 30)];
    noteLabel.text = @"Note: ";
    noteWords = [[UILabel alloc] initWithFrame:CGRectMake(90, 180, 180, 30)];
    noteWords.font = [UIFont systemFontOfSize:15];
    noteWords.text = theLoc.note;
    
    UILabel* tagLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 210, 60, 30)];
    tagLab.text = @"Tags: ";
    tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 210, 180, 30)];
    tagLabel.font = [UIFont systemFontOfSize:15];
    NSMutableArray* theTags = [[NSMutableArray alloc] initWithArray:theLoc->locTags];
    
    tagString = [[NSMutableString alloc] initWithString:@""];
    if ([theTags count] > 0) {
        for (int i = 0; i < [theTags count]; i++) {
            [tagString appendString:[theTags objectAtIndex:i]];
            [tagString appendString:@"   "];
        }
    }
    
    tagLabel.text = tagString;
    
    [self.view addSubview:map];
    [self.view addSubview:nameTitle];
    [self.view addSubview:noteWords];
    [self.view addSubview:tagLabel];
    [self.view addSubview:noteLabel];
    [self.view addSubview:tagLab];
    
    map.delegate = self;
    PinAnnot *pin = [[PinAnnot alloc] initWithCoordinates:theLoc->coordinate placeName: theLoc.title description:theLoc.address];
    pin.title = theLoc->title;
    pin.subtitle = theLoc.address;
    pin.color = @"green";
    [map addAnnotation:pin];
    
    locManager = [[CLLocationManager alloc] init];
    [locManager setDelegate:self];
    [map setShowsUserLocation:YES];
    [locManager setDistanceFilter:kCLDistanceFilterNone];
    [locManager setDesiredAccuracy:kCLLocationAccuracyBest];
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
        return annotationView;
    }
    return nil;
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MKCoordinateRegion region;
    region.center = theLoc.coordinate;
    //change the 2000 when doing filter
    region = MKCoordinateRegionMakeWithDistance(theLoc.coordinate, 500, 500);
    [mapView setRegion:region animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
