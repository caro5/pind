//
//  TourArray.h
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TourArray : NSObject {
    NSMutableArray *tourArray;
}

@property (nonatomic, retain) NSMutableArray *tourArray;

+ (TourArray *)sharedInstance;
@end
