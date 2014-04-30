//
//  AddNotesViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 07/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "AddNotesViewController.h"
#import "CoreDataManager.h"

@interface AddNotesViewController ()


@property(nonatomic,strong) CoreDataManager *coredatamanagerobj;

@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (strong, nonatomic) NSMutableArray *collectingnotes;

@property (weak, nonatomic) IBOutlet UILabel *BookTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *AuthorTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *ExcerptQuote;
@end

@implementation AddNotesViewController

@synthesize bookname,authorname;
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
    
       
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    _collectingnotes = [[NSMutableArray alloc]init];
    
    self.addNotesTextView.delegate = self;
   // self.addNotesTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NotesArea.png"]];
    
    _BookTitleLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    _AuthorTitleLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    _ExcerptQuote.font =[UIFont fontWithName:@"Steiner" size:15];
    _addNotesTextView.font = [UIFont fontWithName:@"Steiner" size:15];
//    AuthorNameTextField.delegate = self;
//    TotalPagesTextField.delegate = self;
    
    _tap.enabled = NO;
    [self.view addGestureRecognizer:_tap];

    coredatamanagerobj = [[CoreDataManager alloc]init];
    
    _bookNameLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    _authorNameLabel.font =[UIFont fontWithName:@"Steiner" size:16];
    
    self.bookNameLabel.text = bookname;
    self.authorNameLabel.text = authorname;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _tap.enabled = YES;
    return YES;
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    _tap.enabled = YES;
//    return YES;
//}

-(void)hideKeyboard
{
    [self.addNotesTextView resignFirstResponder];
    
    
    _tap.enabled = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_BarBackButton:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}

- (IBAction)btn_savenotes:(id)sender {
    
    
    NSString* notesEntered = self.addNotesTextView.text;
    
    [_collectingnotes addObject:notesEntered];
    
   
    
    [coredatamanagerobj StoringNotesForCorrespondingBook:self.bookNameLabel.text SelectedAuthorName:self.authorNameLabel.text Notes:_collectingnotes];
    
    self.addNotesTextView.text = @"";
    
    
}

- (IBAction)btn_posttoFB:(id)sender
{
    
    NSString *strt=self.addNotesTextView.text;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   strt, @"message",
                                   @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                   nil];
    
    // Make the request
    if ([FBSession.activeSession isOpen])
    {
        [FBSession openActiveSessionWithPublishPermissions:[NSArray arrayWithObject:@"publish_actions"]
                                           defaultAudience:FBSessionDefaultAudienceFriends
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
         {
             if (!error && status == FBSessionStateOpen)
             {
                 [FBRequestConnection startWithGraphPath:@"/me/feed"
                                              parameters:params
                                              HTTPMethod:@"POST"
                                       completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
                  {
                      if (!error)
                      {
                          // Link posted successfully to Facebook
                          NSLog(@"Result: %@", result);
                      }
                  }];
                 
             }
             else
             {
                 UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"Error!" message:@"Please Check your network Connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                 
                 [message show];
                 
             }

         }];
        
        
        
        
        
    }
    else
    {
        UIAlertView *connection = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Check your network Connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [connection show];
        
    }
}


//-(void)viewDidAppear:(BOOL)animated
//{
//    coredatamanagerobj = nil;
//    _collectingnotes = nil;
//}
@end
