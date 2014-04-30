//
//  fbfriendlistViewController.m
//  Book Keeper
//
//  Created by bsauniv22 on 10/04/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "fbfriendlistViewController.h"

@interface fbfriendlistViewController ()
{
    NSArray *friendsarray;
    NSArray *groupsarray;
    NSArray *groupidarray;
    NSArray *members;
    NSArray *memberid;
    NSMutableArray *commonfriends;
    UISegmentedControl *segmentedcontrol;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *arrayadded;
@property(nonatomic,strong) CoreDataManager *coredatamanagerobj;
@end

@implementation fbfriendlistViewController
@synthesize selectionsheet;
@synthesize datapick;
@synthesize inputlabel,arrayadded,grpid;
@synthesize str,str1;
@synthesize coredatamanagerobj;

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
    coredatamanagerobj =[[CoreDataManager alloc]init];
    
    self.managedObjectContext = coredatamanagerobj.managedObjectContext;

    [self createUISegment];
    selectionsheet=[[UIActionSheet alloc] initWithTitle:@"Select Group"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
    
    datapick=[[UIPickerView alloc]initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    [self.datapick setDelegate:self];
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [barItems addObject:cancelbtn];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(bookPickerDoneClick:)];
    [barItems addObject:doneBtn];
    
    [pickerDateToolbar setItems:barItems animated:YES];
    
    
    [self.selectionsheet addSubview:pickerDateToolbar];
    
    [self createUISegment];
    [self groups];
    [self friends];
    [self member];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)cancel:(id)sender
{
    [self.selectionsheet dismissWithClickedButtonIndex:0 animated:YES];
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
                                  friendsarray =[dictionary valueForKey:@"name"];
                                  NSLog(@"friend id=%@",friendsarray);
                                  
                              }
                              //[self member];
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
                                  groupidarray=[dictionary valueForKey:@"id"];
                                  groupsarray = [dictionary valueForKey:@"name"];
                                  NSLog(@"group id =%@ group names=%@",groupidarray,groupsarray);
                                  
                              }
                          }];
    
    
    
    
}

- (void)member{
    NSString *uid=@"126064277584463";
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
                                  members = [dictionary valueForKey:@"name"];
                                  memberid=[dictionary valueForKey:@"id"];
                                  NSLog(@"memberid=%@ Group member =%@ ",memberid,members);
                                  
                                  //      [self friends];
                                  
                                  
                                  [self compare];
                              }
                          }];
    
    
}
-(void)compare
{
    // commonfriends=[[NSMutableArray alloc]init];
    
    
    for (int i=0;i<[members count];i++)
        
        for(int j=0;j<[friendsarray count];j++)
        {
            NSString *memname=[members objectAtIndex:i];
            NSString *frenname=[friendsarray objectAtIndex:j];
            //   if ([[members objectAtIndex:i] isEqualToString:[friendidarray objectAtIndex:j]])
            if ([memname isEqualToString:frenname])
            {
                
                [commonfriends addObject:members[i]];
            }
        }NSLog(@"common friends =%@",commonfriends);
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (segmentedcontrol.selectedSegmentIndex==0)
    {
        
        
        return groupsarray.count;
    }else
    {
        return friendsarray.count;
        
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (segmentedcontrol.selectedSegmentIndex==0)
    {
        
        
        return groupsarray[row];
        
    }
    else
        
    {
        return friendsarray[row];
        
        
    }
    
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (segmentedcontrol.selectedSegmentIndex==0)
    {
        
        
    self.inputlabel.text=[groupsarray objectAtIndex:[datapick selectedRowInComponent:0 ]];
    self.inputlabel1.text=[groupidarray objectAtIndex:[datapick selectedRowInComponent:0]];
    }
    else
        
    {
      self.inputlabel.text=[friendsarray objectAtIndex:[datapick selectedRowInComponent:0]];
        
    }
    

}
-(void)bookPickerDoneClick:(id)sender
{
    str=self.inputlabel.text;
    str1=self.inputlabel1.text;
    GrpList * newEntry =[NSEntityDescription insertNewObjectForEntityForName:@"GrpList"
                                                       inManagedObjectContext:self.managedObjectContext];
   // FriendsList *newEntry1=[NSEntityDescription insertNewObjectForEntityForName:@"FriendsList" inManagedObjectContext:self.managedObjectContext];
    
    if (segmentedcontrol.selectedSegmentIndex==0) {
        newEntry.groupname = str;
        newEntry.groupid=str1;
        NSError *error=nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }
    else{
//        newEntry1.friendsname = str;
//        NSError *error=nil;
//        if (![self.managedObjectContext save:&error]) {
//            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//        }
        [self friendlistsave];
    }
    
   
   // grpid=[groupsarray objectAtIndex:[datapick selectedRowInComponent:0 ]];
    //[arrayadded addObject:grpid];
    
    //newEntry.friendname = [friendidarray objectAtIndex:[datapick selectedRowInComponent:0 ]];
    
   
    
    
    [self.selectionsheet dismissWithClickedButtonIndex:1 animated:YES];
    
    
    
    
}
-(void)friendlistsave
{
    str=self.inputlabel.text;
    str1=self.inputlabel1.text;
    FriendsList *newEntry1=[NSEntityDescription insertNewObjectForEntityForName:@"FriendsList" inManagedObjectContext:self.managedObjectContext];
    newEntry1.friendsname = str;
    newEntry1.friendsid=str1;
    NSError *error=nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }

}
-(void)createUISegment

{
    NSArray *itemArray = [NSArray arrayWithObjects: @"Groups", @"Friends", nil];
    segmentedcontrol = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedcontrol.frame = CGRectMake(35, 70, 250, 70);
    [segmentedcontrol addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedcontrol.selectedSegmentIndex = 0;
    
    [self.view addSubview:segmentedcontrol];
}


- (void)segmentChanged:(UISegmentedControl *)segment {
    
    if(segment.selectedSegmentIndex == 0) {
        
        datapick.delegate=self;
        datapick.showsSelectionIndicator=YES;
        [self.selectionsheet addSubview:datapick];
        [self.selectionsheet showInView:self.view];
        [self.selectionsheet setBounds:CGRectMake(0,0,320, 464)];
        
        
        
        
    }
    else{
        
        datapick.delegate=self;
        datapick.showsSelectionIndicator=YES;
        [self.selectionsheet addSubview:datapick];
        
        [self.selectionsheet showInView:self.view];
        [self.selectionsheet setBounds:CGRectMake(0,0,320, 464)];
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
