//
//  TagArray.m
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "TagArray.h"

@implementation TagArray
@synthesize tagArray;

+(TagArray*) sharedInstance {
    static TagArray* tagArrayInst = nil;
    
    if (tagArrayInst == nil) {
        tagArrayInst = [[[self class] alloc] init];
    }
    return tagArrayInst;
}

-(id) init {
    self = [super init];
    if (self) {
        tagArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end

//to get the variable
// [[TagArray sharedInstance] tagArray];

