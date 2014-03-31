//
//  TagArray.h
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagArray : NSObject {
    NSMutableArray *tagArray;
}

@property (nonatomic, retain) NSMutableArray *tagArray;

+ (TagArray *)sharedInstance;


@end

