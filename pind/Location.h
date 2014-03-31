//
//  Location.h
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject {
@public
    CLLocation* loc;
    CLLocationCoordinate2D coordinate;
    NSString* title;
    NSString* address;
    NSMutableArray* locTags;
    NSString* note;
    
}

@property (nonatomic) CLLocation* loc;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* address;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSMutableArray *locTags;
@property (nonatomic, copy) NSString* note;

+(Location *) sharedInstance;

@end
