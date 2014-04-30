//
//  ViewingNotesViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 08/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "ViewingNotesViewController.h"

@interface ViewingNotesViewController ()
{
    UIView *background;
    
}

@end

@implementation ViewingNotesViewController
@synthesize selectedbook,selectedbookNotes;

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
    selectedbookNotes = [NSKeyedUnarchiver unarchiveObjectWithData:[selectedbook valueForKey:@"notes"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,30,33);
    [button setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    
    //[button setTitle:@"  Back" forState:UIControlStateNormal];
    //[button.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
    
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return selectedbookNotes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Steiner" size:16];
    cell.textLabel.text  = [selectedbookNotes objectAtIndex:indexPath.row];
    
    
    
    
    
    
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	 
    
    background = [[UIView alloc]initWithFrame:self.view.bounds];
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(40, 100, 260, 280)];
     bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notes.png"]];
    UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, 260, 275)];
    myTextView.text = [selectedbookNotes objectAtIndex:indexPath.row];
    //some other setup like setting the font for the UITextView...
    //myTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notes.png"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(HideView:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"close.png"]
                        forState:UIControlStateNormal];
    button.frame = CGRectMake(210, 20, 30, 30.0);
    
    
    myTextView.textAlignment = NSTextAlignmentCenter;
    myTextView.backgroundColor = [UIColor clearColor];
    myTextView.font =[UIFont fontWithName:@"Steiner" size:20];
    [myTextView setUserInteractionEnabled:NO];
    myTextView.selectedRange = NSMakeRange(2, 0);
    //add code to customize, e.g. polygonView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:background];
     [background addSubview:bgview];
    [bgview addSubview:myTextView];
    [bgview addSubview:button];
    
   
    
    
    
   
    
    
    
	
    
}



- (void)HideView:(UIButton*)button
{
    
    [background removeFromSuperview];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
