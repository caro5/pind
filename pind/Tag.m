//
//  Tag.m
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "Tag.h"

@implementation Tag
@synthesize tagName, locsWithTag;
//@synthesize tagColor;

+ (Tag*) sharedInstance {
    static Tag *tagInst = nil;
    
    //check if instance exists
    if (nil == tagInst) {
        tagInst = [[[self class] alloc] init];
    }
    
    //return instance of class
    return tagInst;
}

-(id) init {
    self = [super init];
    if (self) {
        self.tagName = [[NSString alloc] init];
       // self.tagColor = [[UIColor alloc] init];
        self.locsWithTag = [[NSMutableArray alloc] init];
    }
    return self;
}


@end