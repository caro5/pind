//
//  PinAnnot.m
//  pind
//
//  Created by Caroline Wong on 2/3/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "PinAnnot.h"

@implementation PinAnnot
@synthesize coordinate, subtitle, title, color;

- (id)initWithCoordinates:(CLLocationCoordinate2D)pinC placeName:placeName description:description {
    self = [super init];
    if (self != nil) {
        coordinate = pinC;
        title = placeName;
        subtitle = description;
      //  color = MKPinAnnotationColorPurple;
    //do pinColor as well later
    }
    return self;
}

- (NSString *)title {
    return [NSString stringWithFormat:@"%@", title];
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@", subtitle];
}

@end
