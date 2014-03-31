//
//  LocArray.m
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "LocArray.h"

@implementation LocArray
@synthesize locArray;

+(LocArray*) sharedInstance {
    static LocArray* locArrayInst = nil;
    if (nil == locArrayInst) {
        locArrayInst = [[[self class] alloc] init];
    }
    return locArrayInst;
}

-(id) init {
    self = [super init];
    if (self) {
        locArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end


//to use variable
// [[LocArray sharedInstance] locArray];