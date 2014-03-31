//
//  NewPinAddTagViewController.m
//  pind
//
//  Created by Caroline Wong on 3/8/14.
//  Copyright (c) 2014 Caroline Wong. All rights reserved.
//

#import "NewPinAddTagViewController.h"
#import "EditAddPinViewController.h"
#import "AddTagViewController.h"
#import "Tag.h"
#import "TagArray.h"

@interface NewPinAddTagViewController ()

@end

@implementation NewPinAddTagViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selTags = [[NSMutableArray alloc] init];
    UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    UIBarButtonItem* newTagButton = [[UIBarButtonItem alloc] initWithTitle:@"add tag" style:UIBarButtonItemStylePlain target:self action:@selector(addTag:)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.rightBarButtonItem = newTagButton;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"tagsVC count: %d", [TagArray sharedInstance].tagArray.count);
    return [TagArray sharedInstance].tagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
      
    }
    
    cell.textLabel.text = [[[TagArray sharedInstance].tagArray objectAtIndex:indexPath.row] tagName];
    
    
    NSLog(@"the tag name in tagVC: %@", [[[TagArray sharedInstance].tagArray objectAtIndex:indexPath.row] tagName]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [selTags removeObject:[[[TagArray sharedInstance].tagArray objectAtIndex:indexPath.row] tagName]];
        [tableView cellForRowAtIndexPath:indexPath].highlighted = NO;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"selCount %d", [selTags count]);

    } else {
        
        [selTags addObject:[[[TagArray sharedInstance].tagArray objectAtIndex:indexPath.row] tagName]];
        NSLog(@"asdf%@", [[[TagArray sharedInstance].tagArray objectAtIndex:indexPath.row] tagName]);
        NSLog(@"selCount %d", [selTags count]);
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [tableView cellForRowAtIndexPath:indexPath].highlighted = YES;
    }
    
}

-(void)back:(id)sender {
    [Location sharedInstance]->locTags = selTags;
    NSLog(@"seltag count %d", [selTags count]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addTag:(id)sender {
        AddTagViewController* addTagVC = [[AddTagViewController alloc] init];
        UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:addTagVC];
        [self presentViewController:navVC animated:YES completion:nil];
    
}

//custom initializer
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
