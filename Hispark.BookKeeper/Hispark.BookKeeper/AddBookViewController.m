//
//  AddBookViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "AddBookViewController.h"
#import "CoreDataManager.h"
#import "HomeViewController.h"

@interface AddBookViewController ()

@property(nonatomic,strong) CoreDataManager *coredatamanagerobj;

@property(nonatomic,strong) HomeViewController  *homeobj;

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (weak, nonatomic) IBOutlet UILabel *BookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *AuthorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalPageLabel;

@end

@implementation AddBookViewController
@synthesize BookNameTextField,AuthorNameTextField,TotalPagesTextField,DateResultLabel;
@synthesize dateActionSheet,datePicker;
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
    
    //code for Hidding Keyboard
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];

    
    BookNameTextField.delegate = self;
    AuthorNameTextField.delegate = self;
    TotalPagesTextField.delegate = self;
    
    _tap.enabled = NO;
    [self.view addGestureRecognizer:_tap];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Berlin Sans FB" size:30];
    //label.shadowColor = [UIColor redColor];
    
    label.textColor = [UIColor colorWithRed:171/255.0 green:36/255.0 blue:44/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = @"Add Book";
    [label sizeToFit];

    
     // Slidebar Code
    
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
    
    
    // Action Sheet Code
    
    
    dateActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Start Date"
                                                  delegate:self
                                         cancelButtonTitle:nil
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:nil];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *cancelbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [barItems addObject:cancelbtn];
    
     [cancelbtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDoneClick:)];
    [barItems addObject:doneBtn];
    
     [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    
    
    
    
    [pickerDateToolbar setItems:barItems animated:YES];
    
    [self.dateActionSheet addSubview:pickerDateToolbar];
    [self.dateActionSheet addSubview:self.datePicker];
    
        [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    //Text Font
    
    _BookTitleLabel.font=[UIFont fontWithName:@"Steiner" size:16];
   // _BookTitleLabel.textColor = [UIColor redColor ];
     _AuthorTitleLabel.font=[UIFont fontWithName:@"Steiner" size:16];
    _TotalPageLabel.font = [UIFont fontWithName:@"Steiner" size:15];
    
    //_btn_startDate.titleLabel.font = [UIFont fontWithName:@"Steiner" size:20];
    
    DateResultLabel.font = [UIFont fontWithName:@"Steiner" size:16];
    
    BookNameTextField.font = [UIFont fontWithName:@"Steiner" size:16];
    AuthorNameTextField.font = [UIFont fontWithName:@"Steiner" size:16];
    TotalPagesTextField.font = [UIFont fontWithName:@"Steiner" size:16];
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tap.enabled = YES;
    return YES;
}

-(void)hideKeyboard
{
    [BookNameTextField resignFirstResponder];
    [AuthorNameTextField resignFirstResponder];
    [TotalPagesTextField resignFirstResponder];
    
    _tap.enabled = NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}




-(void)cancel:(id)sender{
    
    
    [self.dateActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


-(void)datePickerDoneClick:(id)sender{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *dateString = [formatter stringFromDate:self.datePicker.date];
    
    
    DateResultLabel.text = dateString;
    [self.dateActionSheet dismissWithClickedButtonIndex:1 animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_startDate:(id)sender
{
    [BookNameTextField resignFirstResponder];
    [AuthorNameTextField resignFirstResponder];
    [TotalPagesTextField resignFirstResponder];

    [self.dateActionSheet showInView:self.view];
    [self.dateActionSheet setBounds:CGRectMake(0,0,320, 464)];
    
    
}

-(NSDate *)getDateFromString:(NSString *)pstrDate
{
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"dd-MM-yyyy"];
    NSDate *dtPostDate = [df1 dateFromString:pstrDate];
    NSLog(@"%@",dtPostDate);
    return dtPostDate;
}

- (IBAction)btn_saveBookToDatabase:(id)sender
{
    if (![self.BookNameTextField.text isEqualToString:@""] && ![self.AuthorNameTextField.text isEqualToString:@""] && ![self.TotalPagesTextField.text isEqualToString:@""] && ![self.DateResultLabel.text isEqualToString:@""])
    {
        //  1
        BookSet * newEntry =[NSEntityDescription insertNewObjectForEntityForName:@"BookSet"
                                                       inManagedObjectContext:self.managedObjectContext];
        //  2
        newEntry.bookName = self.BookNameTextField.text;
        newEntry.authorName = self.AuthorNameTextField.text;
        
        NSString *str = self.TotalPagesTextField.text;
        int x = [str intValue];
        newEntry.totalPages = [NSNumber numberWithInt:x];
        
        newEntry.startDate = [self getDateFromString:self.DateResultLabel.text];
        
        NSUserDefaults *currentUserName = [NSUserDefaults standardUserDefaults];
        NSString *LoggedinName = [currentUserName stringForKey:@"LoggedInUserName"];
        
        newEntry.cuserName = LoggedinName;
        
        newEntry.completedBook = [NSNumber numberWithBool:NO];
        
        //  3
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        //  4
        self.BookNameTextField.text = @"";
        self.AuthorNameTextField.text = @"";
        self.TotalPagesTextField.text = @"";
        
        self.DateResultLabel.text = @"";
        //  5
        
        
       
    }
    
    else
    {
        UIAlertView *alertUser = [[UIAlertView alloc]initWithTitle:@"Warning !" message:@"Your Book Was Not Saved Please Enter All the Details" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertUser show];
    }

    
}
@end
