//
//  EditAddPinViewController.h
//  pind
//
//  Created by Caroline Wong on 2/21/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface EditAddPinViewController : UIViewController <UINavigationControllerDelegate> {
    @public
    Location* aLoc;
}

@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *addrField;
@property (strong, nonatomic) UITextField *noteField;
@property (strong, nonatomic) UIBarButtonItem *saveButton;
@property (strong, nonatomic) UITextField *tagList;
@property (strong, nonatomic) NSMutableString* tagTexts;

@property (strong, nonatomic) UIButton *addTags;

@property(strong, nonatomic) NSString* locQueryName;
@property(strong, nonatomic) NSString* locQueryAddr;

@end
