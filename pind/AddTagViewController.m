//
//  AddTagViewController.m
//  pind
//
//  Created by Caroline Wong on 3/4/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "AddTagViewController.h"
#import "Tag.h"
#import "TagArray.h"


@interface AddTagViewController () {
    NSString* tagName;
    Tag *aTag;
}

@end

@implementation AddTagViewController
@synthesize addTagLabel, tagText, doneButton, fromTagVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (fromTagVC == NO) {
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    addTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 50, 30)];
    [addTagLabel setText:@"name"];
     [self tagText].delegate = self;
    
    tagText = [[UITextField alloc] initWithFrame:CGRectMake(90, 80, 180, 30)];
    tagText.borderStyle = UITextBorderStyleRoundedRect;
    tagText.font = [UIFont systemFontOfSize:15];
    tagText.placeholder = @"add tag name";
    tagText.keyboardType = UIKeyboardTypeDefault;
    tagText.returnKeyType = UIReturnKeyDone;
    tagText.clearButtonMode = UITextFieldViewModeWhileEditing;
    tagText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tagText.delegate = self;
    
    
    [self.view addSubview:addTagLabel];
    [self.view addSubview:tagText];
    [self.view addSubview:doneButton];


}
-(void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save:(id)sender {
    NSLog(@"save");
   
    tagName = tagText.text;
    [Tag sharedInstance].tagName = tagName;
    aTag = [[Tag alloc] init];
    aTag.tagName = tagName;
    [[TagArray sharedInstance].tagArray addObject:aTag];

 
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
