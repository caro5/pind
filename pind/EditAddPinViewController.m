//
//  EditAddPinViewController.m
//  pind
//
//  Created by Caroline Wong on 2/21/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "EditAddPinViewController.h"
#import "AddTagViewController.h"
#import "TagsViewController.h"
#import "NewPinAddTagViewController.h"
#import "Tag.h"
#import "TagArray.h"
#import "LocArray.h"
#import "Location.h"
#import "EditAddTextField.h"

@interface EditAddPinViewController ()

@end

@implementation EditAddPinViewController
@synthesize nameField, addrField, noteField, saveButton, addTags, tagList, tagTexts;
@synthesize locQueryName, locQueryAddr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    tagTexts = [[NSMutableString alloc] initWithString:@""];
    [self.view reloadInputViews];
    if (![nameField.text isEqualToString:@""]) {
        if ([Location sharedInstance]->locTags.count > 0) {
            for (int i = 0; i < [Location sharedInstance]->locTags.count; i++) {
                [tagTexts appendString:[[Location sharedInstance]->locTags objectAtIndex:i]];
                [tagTexts appendString:@"   "];
            }
        }
        tagList.text = tagTexts;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    UIBarButtonItem* saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    nameField = [[EditAddTextField alloc] initWithFrame:CGRectMake(90, 80, 180, 30)];
    if ([locQueryName length] == 0) {
    nameField.placeholder = @"add name";
    } else {
        nameField.text = locQueryName;
    }
    nameField.delegate = self;
    
    addrField = [[EditAddTextField alloc] initWithFrame:CGRectMake(90, 130, 180, 30)];
    if ([locQueryAddr length] == 0) {
        addrField.placeholder = @"add address";
    } else {
        addrField.text = locQueryAddr;
    }
    addrField.delegate = self;
    
    noteField = [[EditAddTextField alloc] initWithFrame:CGRectMake(90, 180, 180, 30)];
    noteField.placeholder = @"add note";
    self.noteField.delegate = self;
    
    addTags = [[UIButton alloc] initWithFrame:CGRectMake(90, 230, 150, 30)];
    addTags.backgroundColor = [UIColor grayColor];
    [addTags addTarget:self action:@selector(addTag:) forControlEvents:UIControlEventTouchUpInside];
    [addTags setTitle:@"add tags" forState:UIControlStateNormal];
    
    tagList = [[UITextField alloc] initWithFrame:CGRectMake(90,280, 200, 30)];
    [tagList setUserInteractionEnabled:NO];
    [self.view addSubview:nameField];
    [self.view addSubview:addrField];
    [self.view addSubview:noteField];
    [self.view addSubview:addTags];
    [self.view addSubview:tagList];
    
    // Do any additional setup after loading the view.
}

-(void)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)save:(id)sender {
    NSLog(@"save");
    
    NSString* locName = nameField.text;
    NSString* noteString = noteField.text;
    aLoc = [[Location alloc] init];
    aLoc->loc = [Location sharedInstance]->loc;
    aLoc->coordinate = [Location sharedInstance]->coordinate;
    aLoc->address = addrField.text;
    aLoc->title = locName;
    aLoc->note = noteString;
    NSLog(@"tagname : %@", [[Tag sharedInstance] tagName]);
    
    aLoc->locTags = [Location sharedInstance]->locTags;
    [[LocArray sharedInstance].locArray addObject:aLoc];
    
    //save the location to the tags
    for (Tag* aTag in [TagArray sharedInstance].tagArray) {
        for (Tag *locTag in aLoc->locTags) {
            if ([[aTag tagName] isEqual:locTag]) {
                [aTag.locsWithTag addObject:aLoc];
            }
        }
    }
    
    
    NSLog(@"%f", aLoc->coordinate.latitude);
    NSLog(@"%@", aLoc.title);
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

-(void) addTag:(id)sender {
    NSLog(@"in addTag");
    //    TagsViewController *tagsVC = [[TagsViewController alloc] initWithStyle:UITableViewCellAccessoryCheckmark];
    //    AddTagViewController* addTagVC = [[AddTagViewController alloc] init];
    //
    //    UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:addTagVC];
    //    [self presentViewController:navVC animated:YES completion:nil];
    
    
    NewPinAddTagViewController* npVC = [[NewPinAddTagViewController alloc] init];
    UINavigationController* naviVC = [[UINavigationController alloc] initWithRootViewController:npVC];
    [self presentViewController:naviVC animated:YES completion:nil];
    
}

//- (void)addPin:(id)sender {
//    NSLog(@"here in addPin");
//    EditAddPinViewController *edAddVC = [[EditAddPinViewController alloc] init];
//    UINavigationController * navVC = [[UINavigationController alloc] init];
//    [navVC pushViewController:edAddVC animated:NO];
//    [Location sharedInstance]->loc = locManager.location;
//    [Location sharedInstance]->coordinate = locManager.location.coordinate;
//    [self presentViewController:navVC animated:YES completion:nil];
//}

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
