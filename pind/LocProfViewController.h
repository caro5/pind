//
//  LocProfViewController.h
//  pind
//
//  Created by Caroline Wong on 3/3/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface LocProfViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation> {
    CLLocationManager* locManager;
}
@property (strong, nonatomic) UILabel *nameTitle;
@property (strong, nonatomic) UILabel *noteLabel;
@property (strong, nonatomic) UILabel *tagTitle;
@property (strong, nonatomic) UILabel *tagLabel;
@property (strong, nonatomic) UILabel *noteWords;

@property (strong, nonatomic) NSString* locationName;
@property (strong, nonatomic) NSString* noteString;
@property (strong, nonatomic) NSMutableString* tagString;

@property(retain, nonatomic) MKMapView* map;
@property (strong, nonatomic) Location* theLoc;

@end
