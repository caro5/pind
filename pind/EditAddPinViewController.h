//
//  EditAddPinViewController.h
//  pind
//
//  Created by Caroline Wong on 2/21/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface EditAddPinViewController : UIViewController <UINavigationControllerDelegate, UITextFieldDelegate> {
    @public
    Location* aLoc;
}

@property (retain, nonatomic) UITextField *nameField;
@property (retain, nonatomic) UITextField *addrField;
@property (retain, nonatomic) UITextField *noteField;
@property (strong, nonatomic) UIBarButtonItem *saveButton;
@property (retain, nonatomic) UITextField *tagList;
@property (strong, nonatomic) NSMutableString* tagTexts;

@property (strong, nonatomic) UIButton *addTags;

@property(strong, nonatomic) NSString* locQueryName;
@property(strong, nonatomic) NSString* locQueryAddr;

-(void)cancel:(id)sender;
-(void)save:(id)sender;
-(void) addTag:(id)sender;



@end
