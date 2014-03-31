//
//  AddTagViewController.h
//  pind
//
//  Created by Caroline Wong on 3/4/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTagViewController : UIViewController 

@property (strong, nonatomic) UILabel *addTagLabel;
@property (strong, nonatomic) UITextField *tagText;
@property (strong, nonatomic) UIButton *doneButton;
@property (nonatomic, assign) BOOL fromTagVC;

@end
