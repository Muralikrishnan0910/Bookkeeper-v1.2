//
//  tablegrouplistViewController.m
//  Book Keeper
//
//  Created by bsauniv22 on 25/04/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "tablegrouplistViewController.h"

@interface tablegrouplistViewController ()
{
    FriendsList *listobj;
}
@property(nonatomic,strong)NSMutableArray *addedcommonfriendsnames;
@property (nonatomic,strong)CoreDataManager *coredatamanagerobj;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation tablegrouplistViewController
@synthesize addedcommonfriendsnames,coredatamanagerobj;
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
	// Do any additional setup after loading the view.
    coredatamanagerobj = [[CoreDataManager alloc]init];
    self.managedObjectContext = coredatamanagerobj.managedObjectContext;
    addedcommonfriendsnames=[coredatamanagerobj GetalladdedCommonFriends];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return addedcommonfriendsnames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    listobj = [addedcommonfriendsnames objectAtIndex:indexPath.row];
    //  cell.textLabel.font =[UIFont fontWithName:@"Steiner" size:22];
    //cell.detailTextLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    cell.textLabel.text  = listobj.friendsname;
    
    return cell;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
