//
//  CurrentlyReadingViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property(nonatomic,strong)CoreDataManager *coredatamanagerobj;

@property(nonatomic,strong)UpdateViewController *updateviewcontrollerobj;

@property(nonatomic,strong)AddNotesViewController *addnotesviewcontrollerobj;

@property(nonatomic,strong)NSManagedObjectContext *managedobjectcontext;

@property(nonatomic,strong) BookSet *bookobj;

@property(nonatomic,strong)NSArray *bookData;

@property (weak, nonatomic) IBOutlet UITableView *mytable;

@end

@implementation HomeViewController
@synthesize coredatamanagerobj,addnotesviewcontrollerobj,updateviewcontrollerobj;
@synthesize bookData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    addnotesviewcontrollerobj = [[AddNotesViewController alloc]init];
    
    //updateviewcontrollerobj = [[UpdateViewController alloc]init];
    //Loding books from Database
    coredatamanagerobj = [[CoreDataManager alloc]init];
    
    
    self.managedobjectcontext = coredatamanagerobj.managedObjectContext;
    
    
    
    bookData = [coredatamanagerobj GetAllBooks];
    
    _sidebarButton.tintColor = [UIColor colorWithRed:171/255.0 green:36/255.0 blue:44/255.0 alpha:1.0];
    
    //self.myTableView.delegate = self;
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    //Add image for Navigation Bar
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigation"] forBarMetrics: UIBarMetricsDefault];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Berlin Sans FB" size:30];
    //label.shadowColor = [UIColor redColor];
    
    label.textColor = [UIColor colorWithRed:171/255.0 green:31/255.0 blue:44/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = @"Home";
    [label sizeToFit];
    
    
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
//converting string from NSdate to display it in currently reading view
-(NSString *)getDateFromString:( NSDate*)pstrDate
{
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"dd-MM-yyyy"];
    NSString *dtPostDate = [df1 stringFromDate:pstrDate];
    NSLog(@"%@",dtPostDate);
    return dtPostDate;
}


//Adding Notes Method

-(IBAction)AddnotesnavigateAction:(id)sender
{
    UIButton *tembtn=(UIButton *)sender;
    BookSet *tempObj=[bookData objectAtIndex:tembtn.tag];
    
    NSLog(@"%@",tempObj.bookName);

  
    
        addnotesviewcontrollerobj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AddNotesViewController1"];
        [addnotesviewcontrollerobj setBookname:tempObj.bookName];
        [addnotesviewcontrollerobj setAuthorname:tempObj.authorName];
        
        [self presentViewController:addnotesviewcontrollerobj animated:NO completion:nil];

   }

//Update Pages Read Method
-(IBAction)UpdatenavigateAction:(id)sender
{
    UIButton *tembtn=(UIButton *)sender;
    BookSet *tempObj=[bookData objectAtIndex:tembtn.tag];
    
    NSLog(@"%@",tempObj.bookName);
    
    
    updateviewcontrollerobj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"UpdateViewController"];
    [updateviewcontrollerobj setBookName:tempObj.bookName];
    [updateviewcontrollerobj setAuthorName:tempObj.authorName];
    [updateviewcontrollerobj setTotalPages:tempObj.totalPages];
    [updateviewcontrollerobj setStartDate:tempObj.startDate];
    
    [self presentViewController:updateviewcontrollerobj animated:NO completion:nil];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return bookData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    currentlyReadingCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell = [[currentlyReadingCustomCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    self.bookobj =  [bookData objectAtIndex:indexPath.row];
    
    [cell.bookNameLabel setFont:[UIFont boldSystemFontOfSize:50]];
    cell.bookNameLabel.font=[UIFont fontWithName:@"Steiner" size:25];
    
    cell.bookNameLabel.text = self.bookobj.bookName;
    
    cell.authorNameLabel.font=[UIFont fontWithName:@"Steiner" size:18];
    cell.authorNameLabel.text = self.bookobj.authorName;
   // cell.dateLabel.font = [UIFont fontWithName:@"Steiner" size:10];
    cell.dateLabel.text = [self getDateFromString:self.bookobj.startDate];
    //[cell.dateLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
    cell.dateLabel.font=[UIFont fontWithName:@"Steiner" size:13];
    //[cell.progress setThumbImage:[UIImage imageNamed:@"ball.png"]  forState:UIControlStateNormal];
    //cell.progress.thumbTintColor = [UIColor clearColor];
    float x = [self.bookobj.totalPages floatValue];
    float y =  [self.bookobj.pagesRead floatValue];
   
    float z = y/x;
    int roundValue = z * 100;
    NSString * percentage=@"%";
    cell.percentLabel.text =[NSString stringWithFormat:@"%i%@",roundValue,percentage];
    [cell.percentLabel setFont:[UIFont boldSystemFontOfSize:50]];
     cell.percentLabel.font=[UIFont fontWithName:@"Steiner" size:15];
    [cell.progress setTransform:CGAffineTransformMakeScale(1.0, 5.0)];
    [cell.progress setProgress:z] ;
    
    
    
    
   
    
    [cell.btn_addExceprts setTag:indexPath.row];
    cell.btn_addExceprts.titleLabel.font = [UIFont fontWithName:@"Berlin Sans FB" size:15];
    
    [cell.btn_UpdateButton setTag:indexPath.row];
    cell.btn_UpdateButton.titleLabel.font = [UIFont fontWithName:@"Berlin Sans FB" size:15];
    
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBackground.png"]];
    
    
    
    
   // [cell.btn_addExceprts addTarget:self action:@selector(customActionPressed:)  forControlEvents:UIControlEventTouchDown];
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //    1
        [tableView beginUpdates];
        // Delete the row from the data source
        
        //    2
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //    3
        [self.managedobjectcontext deleteObject:[self.bookData objectAtIndex:indexPath.row]];
        NSError *error;
        if (![self.managedobjectcontext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        //    4
        
        self.bookData = [coredatamanagerobj GetAllBooks];
        //    5
        [tableView endUpdates];
    }
    
            // Remove the row from data model
//    [self.managedobjectcontext deleteObject:[self.bookData objectAtIndex:indexPath.row]];
//            NSError *error;
//            if (![self.managedobjectcontext save:&error]) {
//                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//           }
//        // Request table view to reload
//        [tableView reloadData];
    
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove the row from data model
////    [tableData removeObjectAtIndex:indexPath.row];
//    
//    // Request table view to reload
//    [tableView reloadData];
//}

-(void)viewWillAppear:(BOOL)animated
{
    
    bookData = [coredatamanagerobj GetAllBooks];
//    [self.view setNeedsDisplay];
      [self.mytable reloadData];
}

-(void)viewDidDisappear:(BOOL)animated
{
    coredatamanagerobj = [[CoreDataManager alloc]init];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
