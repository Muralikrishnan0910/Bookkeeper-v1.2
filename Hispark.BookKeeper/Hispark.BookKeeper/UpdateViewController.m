//
//  UpdateViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 07/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "UpdateViewController.h"
#import "HomeViewController.h"

@interface UpdateViewController ()

@property(nonatomic,strong) CoreDataManager *coredatamanagerobj;

@property(nonatomic,strong) HomeViewController *homeObj;

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (weak, nonatomic) IBOutlet UILabel *BooKTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *AuthorTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *TotalPagesTitle;

@property (weak, nonatomic) IBOutlet UILabel *PagesCompletedTitle;

@end

@implementation UpdateViewController
@synthesize booKNameLabel,authorNameLabel,totalNumberOfPages,startDateLabel;
@synthesize bookName,authorName,TotalPages,startDate,coredatamanagerobj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Method to convert nsdate to nsstring

-(NSString *)getDateFromString:( NSDate*)pstrDate
{
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:@"dd-MM-yyyy"];
    NSString *dtPostDate = [df1 stringFromDate:pstrDate];
    NSLog(@"%@",dtPostDate);
    return dtPostDate;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _tap.enabled = YES;
    return YES;
}

-(void)hideKeyboard
{
    
    [self.pagesCompletedTextField resignFirstResponder];
    
    _tap.enabled = NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad
{
    
    
    coredatamanagerobj = [[CoreDataManager alloc]init];
    
    
    self.booKNameLabel.text = bookName;
    self.authorNameLabel.text = authorName;
    self.totalNumberOfPages.text = [NSString stringWithFormat:@"%li",(long)[TotalPages integerValue]];
    self.startDateLabel.text =[self getDateFromString:startDate];
    
    //code for Hidding Keyboard
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    
    self.pagesCompletedTextField.delegate = self;
    
    
    _tap.enabled = NO;
    
   
    [self.view addGestureRecognizer:_tap];
    
    
    _BooKTitleLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    _AuthorTitleLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    _TotalPagesTitle.font =[UIFont fontWithName:@"Steiner" size:15];
    _PagesCompletedTitle.font =[UIFont fontWithName:@"Steiner" size:15];
    startDateLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    booKNameLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    authorNameLabel.font = [UIFont fontWithName:@"Steiner" size:16];
    totalNumberOfPages.font = [UIFont fontWithName:@"Steiner" size:16];
    _pagesCompletedTextField.font = [UIFont fontWithName:@"Steiner" size:16];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_Bar_BackButton:(id)sender
{
//     self.homeObj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self presentViewController:self.homeObj animated:NO completion:nil];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)btn_UpdateAction:(id)sender
{
    if ([self.pagesCompletedTextField.text intValue] <= [self.TotalPages intValue])
    {
        [coredatamanagerobj UpdatePagesField:self.booKNameLabel.text SelectedAuthor:self.authorNameLabel.text PageEntered:self.pagesCompletedTextField.text];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"Warning!" message:@"Please Enter Page Number Less Than Total Pages" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
@end
