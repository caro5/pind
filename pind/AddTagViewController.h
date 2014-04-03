//
//  AddTagViewController.h
//  pind
//
//  Created by Caroline Wong on 3/4/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTagViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UILabel *addTagLabel;
@property (strong, nonatomic) UITextField *tagText;
@property (strong, nonatomic) UIButton *doneButton;
@property (nonatomic, assign) BOOL fromTagVC;


-(void)cancel:(id)sender;
-(void)save:(id)sender;
    
    
    
@end
