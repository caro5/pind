//
//  PinsViewController.h
//  pind
//
//  Created by Caroline Wong on 2/19/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface PinsViewController : UITableViewController <CLLocationManagerDelegate, MKAnnotation>

@property (nonatomic, assign) BOOL fromTag;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSString *tagName;
@end
