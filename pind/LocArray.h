//
//  LocArray.h
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocArray : NSObject {
    NSMutableArray *locArray;
}

@property (nonatomic, retain) NSMutableArray *locArray;

+ (LocArray *)sharedInstance;

@end
