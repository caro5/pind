//
//  Tour.m
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "Tour.h"

@implementation Tour
@synthesize  tourName, tourLocs;

+(Tour *)sharedInstance {
    Tour *tourInst = nil;
    if (nil == tourInst) {
        tourInst = [[[self class] alloc] init];
    }
    // return the instance of this class
    return tourInst;
}

-(id) init {
    self = [super init];
    if (self) {
        self.tourName = [[NSString alloc] init];
        
        self.tourLocs = [[NSMutableArray alloc] init];
        
    }
    return self;
}

@end
