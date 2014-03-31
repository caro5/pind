//
//  Location.m
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize loc, title, locTags, note, address, coordinate;


+ (Location*) sharedInstance {
    static Location* locInst = nil;
    
    if (nil == locInst) {
        locInst = [[[self class] alloc] init];
    }
    return locInst;
}

-(id) init {
    self = [super init];
    if (self) {
        self.title = [[NSString alloc] init];
        self.address = [[NSString alloc] init];
        loc = [[CLLocation alloc] init];
        self.coordinate = CLLocationCoordinate2DMake(0, 0);
        self.locTags = [[NSMutableArray alloc] init];
        self.note = [[NSString alloc] init];
    }
    return self;
}

@end

