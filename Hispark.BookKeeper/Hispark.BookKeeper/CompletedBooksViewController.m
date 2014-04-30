//
//  CompletedBooksViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "CompletedBooksViewController.h"
#import "ViewingNotesViewController.h"

@interface CompletedBooksViewController ()
{
    BookSet *booksetobj;
    ViewingNotesViewController *viewnotesviewcontrollerobj;
}

@property (nonatomic,strong)NSMutableArray *completedBookDatas;
@property (nonatomic,strong)CoreDataManager *coredatamanagerobj;

@end

@implementation CompletedBooksViewController
@synthesize completedBookDatas,coredatamanagerobj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return completedBookDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    booksetobj = [completedBookDatas objectAtIndex:indexPath.row];
    cell.textLabel.font =[UIFont fontWithName:@"Steiner" size:22];
    cell.detailTextLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    cell.textLabel.text  = booksetobj.bookName;
    cell.detailTextLabel.text = booksetobj.authorName;
    
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	viewnotesviewcontrollerobj =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewingNotesViewController"];
    
    viewnotesviewcontrollerobj.selectedbook =[self.completedBookDatas objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewnotesviewcontrollerobj animated:YES];
   
	
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImage *myImage = [UIImage imageNamed:@"CompletedBookBarImage.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,300,100);
    
    return imageView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 75;
}



- (void)viewDidLoad
{
    
   
    
   // viewnotesviewcontrollerobj = [[ViewingNotesViewController alloc]init];
    
    coredatamanagerobj = [[CoreDataManager alloc]init];
    
    completedBookDatas = [coredatamanagerobj GetAllCompletedBooks];
    
    NSLog(@"completed book %@",completedBookDatas);
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,35,28);
    [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    button.tintColor = [UIColor colorWithRed:171/255.0 green:36/255.0 blue:44/255.0 alpha:1.0];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button ];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Add image for Navigation Bar
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigation"] forBarMetrics: UIBarMetricsDefault];

    

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
