//
//  Tag.h
//  pind
//
//  Created by Caroline Wong on 1/25/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tag : NSObject {
    NSString *tagName;
    NSMutableArray* locsWithTag;
  //  UIColor *color;
    
}

@property (nonatomic, copy) NSString *tagName;
//@property (nonatomic, copy) UIColor *tagColor;
@property (nonatomic, retain) NSMutableArray *locsWithTag;


+ (Tag *)sharedInstance;
@end
