//
//  MainMapViewController.h
//  pind
//
//  Created by Caroline Wong on 2/19/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MainMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation, UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIActionSheetDelegate> {
    CLLocationManager* locManager;
    UISearchDisplayController *searchDC;
    UITableView *searchTable;
    UISearchBar *searchBar;
    NSString *searchWords;
    
    
}

@property (retain, nonatomic) MKMapView* map;
@property (retain, nonatomic) UIButton* addPin;
@property (retain, nonatomic) NSString* searchWords;
@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UITableView* searchTable;


@property (strong, nonatomic) NSArray *placesArray;
@property (strong, nonatomic) CLLocation* currentLoc;
@property (strong, nonatomic) NSString* searchTerm;
@property (assign, nonatomic) CLLocation* currLoc;

@property (retain, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) UIImage *image;
@property (strong, nonatomic) CLLocation *selectedLoc;
@property (strong, nonatomic) NSMutableDictionary *geoDict;
@property (retain, nonatomic) NSString* address;
@property (retain, nonatomic) NSString* city;
@property (retain, nonatomic) NSString* state;
@property (retain, nonatomic) NSString* zip;


-(void) cancelClicked:(id)sender;
-(void) showLocArrayPins;
-(void) plotPositions:(NSArray *)data;
-(void) addPin:(id)sender;
-(void) savingCurrentLoc;
-(void) setLoc;
-(void) reverseGeoCode;
-(void) makeQuery;
-(void) addButtonTapped:(id)sender event:(id)event;


@end
