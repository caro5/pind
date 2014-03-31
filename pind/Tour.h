//
//  Tour.h
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tour : NSObject {
    NSString *tourName;
    NSMutableArray *tourLocs;
}

@property (nonatomic, copy) NSString* tourName;
@property (nonatomic, retain) NSMutableArray* tourLocs;

+ (Tour *) sharedInstance;


@end
