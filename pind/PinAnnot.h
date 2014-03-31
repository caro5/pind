//
//  PinAnnot.h
//  pind
//
//  Created by Caroline Wong on 2/3/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PinAnnot : NSObject <MKAnnotation> {
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D pinCoord;
    
    NSString* color;
   // MKPinAnnotationColor* color;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *color;
//@property (nonatomic, assign) MKPinAnnotationColor* color;


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id)initWithCoordinates:(CLLocationCoordinate2D)pinCoord placeName:placeName description:description;


@end
