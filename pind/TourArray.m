//
//  TourArray.m
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "TourArray.h"

@implementation TourArray
@synthesize tourArray;

+ (TourArray *)sharedInstance {
    // the instance of this class is stored here
    static TourArray *tourArrayInst = nil;
    
    // check to see if an instance already exists
    if (nil == tourArrayInst) {
        tourArrayInst = [[[self class] alloc] init];
    }
    // return the instance of this class
    return tourArrayInst;
}

-(id) init {
    self = [super init];
    if (self) {
        tourArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
