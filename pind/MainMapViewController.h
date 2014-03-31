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


@interface MainMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation, UISearchDisplayDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    CLLocationManager* locManager;
    UISearchDisplayController *searchDC;
    UITableView *searchTable;
    UISearchBar *searchBar;
    NSString *searchWords;
    
    
}

@property(retain, nonatomic) MKMapView* map;
@property(retain, nonatomic) UIButton* addPin;
@property(retain, nonatomic) NSString* searchWords;
@property(strong, nonatomic) NSArray *searchResults;
@property(strong, nonatomic) UISearchBar *searchBar;
@property(strong, nonatomic) UITableView* searchTable;

@property (strong, nonatomic) NSArray *placesArray;
@property (strong, nonatomic) CLLocation* currentLoc;
@property (strong, nonatomic) NSString* searchTerm;
@property (assign, nonatomic) CLLocation* currLoc;

@end
