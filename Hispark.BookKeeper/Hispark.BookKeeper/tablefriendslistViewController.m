//
//  tablefriendslistViewController.m
//  Book Keeper
//
//  Created by bsauniv22 on 11/04/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "tablefriendslistViewController.h"

@interface tablefriendslistViewController ()
{
    GrpList *listobj;
    NSArray *friendsarray;
    NSArray *groupsarray;
    NSArray *members;
    NSString *commonfriendsname;
    NSString *commonfriendsid;
    NSMutableArray *commonfriends;
}


@property(nonatomic,strong)NSMutableArray *addedgroupnames;
@property (nonatomic,strong)CoreDataManager *coredatamanagerobj;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,strong)NSArray *st;
@end

@implementation tablefriendslistViewController
@synthesize addedgroupnames,coredatamanagerobj;
@synthesize idstr,st;
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
     commonfriends=[[NSMutableArray alloc]init];
    coredatamanagerobj = [[CoreDataManager alloc]init];
    self.managedObjectContext = coredatamanagerobj.managedObjectContext;
    addedgroupnames=[coredatamanagerobj GetalladdedGroups];
	// Do any additional setup after loading the view.
}

- (void)friends {
    
    
    NSString *uid=@"100007926850464";
    NSString *path=[NSString stringWithFormat:@"%@/friends",uid];
    
    
    [FBRequestConnection startWithGraphPath:path
                                 parameters:NULL
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error is: %@", [error localizedDescription]);
                              } else {
                                  
                                  // NSLog(@"Result: %@", result);
                                  FBGraphObject * details =result;
                                  NSDictionary *dictionary=[details objectForKey:@"data"];
                                  friendsarray =[dictionary valueForKey:@"id"];
                                  NSLog(@"friend id=%@",friendsarray);
                                  
                              }
                              [self member];
                          }];
    
    
}
-(void)groups{
    NSString *gid=@"100007926850464";
    
    NSString *path=[NSString stringWithFormat:@"%@/groups",gid];
    
    [FBRequestConnection startWithGraphPath:path
                                 parameters:NULL
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error is: %@", [error localizedDescription]);
                              } else {
                                  
                                  // NSLog(@"Result: %@", result);
                                  FBGraphObject *postDetails = result;
                                  //NSLog(@"----->%@",postDetails);
                                  NSDictionary *dictionary=[postDetails objectForKey:@"data"];
                                  groupsarray = [dictionary valueForKey:@"name"];
                                  NSLog(@"group id=%@",groupsarray);
                                  
                              }
                          }];
    
    
    
    
}

- (void)member{
    
    NSString *uid=idstr;
    NSString *path=[NSString stringWithFormat:@"%@/members",uid];
    
    
    
    [FBRequestConnection startWithGraphPath:path
                                 parameters:NULL
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error is: %@", [error localizedDescription]);
                              } else {
                                  
                                  NSLog(@"Result: %@", result);
                                  FBGraphObject *postDetails = result;
                                  //NSLog(@"----->%@",postDetails);
                                  NSDictionary *dictionary=[postDetails objectForKey:@"data"];
                                  members = [dictionary valueForKey:@"id"];
                                  NSLog(@"Group member =%@",members);
                                  
                                  //     [self friends];
                                  
                                  [self compare];
                                 
                              }
                          }];
    
    
}
-(void)compare
{
    for (int i=0;i<[members count];i++)
        
        for(int j=0;j<[friendsarray count];j++)
        {
            NSString *memname=[members objectAtIndex:i];
            NSString *frenname=[friendsarray objectAtIndex:j];
            //   if ([[members objectAtIndex:i] isEqualToString:[friendidarray objectAtIndex:j]])
            if ([memname isEqualToString:frenname])
            {
                
                [commonfriends addObject:members[i]];
                st=members[i];
                NSLog(@"frndsid>>>>><<<<<<<<%@",st);
                NSString *path=[NSString stringWithFormat:@"%@/?fields=name",members[i]];
                [FBRequestConnection startWithGraphPath:path
                                             parameters:nil
                                             HTTPMethod:@"GET"
                                      completionHandler:^(
                                                          FBRequestConnection *connection,
                                                          id result,
                                                          NSError *error
                                                          ) {
                                          FBGraphObject * details =result;
                                          NSDictionary *dictionary=[details objectForKey:@"name"];
                                          NSDictionary *dictionary1=[details objectForKey:@"id"];
                                          commonfriendsname=dictionary;
                                          commonfriendsid=dictionary1;
                                          NSLog(@"friendsname??????%@",commonfriendsname);
                                          NSLog(@"Friends Name>>>>>>%@",result);
                            FriendsList * newEntry =[NSEntityDescription insertNewObjectForEntityForName:@"FriendsList"
                                                                                                inManagedObjectContext:self.managedObjectContext];
                            newEntry.friendsname=commonfriendsname;
                            newEntry.friendsid=commonfriendsid;
                            NSError *error1=nil;
                            if (![self.managedObjectContext save:&error1]) {
                                              NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                                          }
                                      }];
               
            }
        }NSLog(@"common friends =%@",commonfriends);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return addedgroupnames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    listobj = [addedgroupnames objectAtIndex:indexPath.row];
  //  cell.textLabel.font =[UIFont fontWithName:@"Steiner" size:22];
    //cell.detailTextLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    cell.textLabel.text  = listobj.groupname;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    listobj=[addedgroupnames objectAtIndex:indexPath.row];
    idstr=listobj.groupid;
    NSLog(@"IDString..........%@",idstr);
	 [self friends];
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIImage *myImage = [UIImage imageNamed:@"CurrentlyReadingBarImage.png"];
//   UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
//    imageView.frame = CGRectMake(10,10,300,100);
//    
//    return imageView;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 75;
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end



