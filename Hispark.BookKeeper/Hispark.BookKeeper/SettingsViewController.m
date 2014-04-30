//
//  SettingsViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "SettingsViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FBLOGININTERFACEVC.h"

@interface SettingsViewController ()
{
     UIView *background;
}

@property(nonatomic,strong)FBLOGININTERFACEVC *FBobj;

@end

@implementation SettingsViewController
@synthesize FBobj;

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
    
   
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,35,28);
    [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    button.tintColor = [UIColor colorWithRed:255/255.0 green:3/255.0 blue:100/255.0 alpha:1.0];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button ];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"navigation"] forBarMetrics: UIBarMetricsDefault];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Berlin Sans FB" size:30];
    //label.shadowColor = [UIColor redColor];
    
    label.textColor = [UIColor colorWithRed:171/255.0 green:36/255.0 blue:44/255.0 alpha:1.0];
    self.navigationItem.titleView = label;
    label.text = @"Settings";
    [label sizeToFit];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (IBAction)buttonTouched:(id)sender
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        FBobj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"FBLOGININTERFACEVC"];
        
        [self presentViewController:FBobj animated:NO completion:nil];
        
    }
    
    
    
    
    // If the session state is not any of the two "open" states when the button is clicked
    else {
        
        [FBSession.activeSession closeAndClearTokenInformation];
        FBobj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"FBLOGININTERFACEVC"];
        [self presentViewController:FBobj animated:NO completion:nil];
        
    }
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_AboutUS:(id)sender
{
    
    background = [[UIView alloc]initWithFrame:self.view.bounds];
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(40, 50, 260, 400)];
    bgview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"AboutUsNotes.png"]];
    UITextView *myTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 50, 260, 280)];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(HideView:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"close.png"]
                      forState:UIControlStateNormal];
    button.frame = CGRectMake(210, 20, 30, 30.0);
    
    myTextView.text = @"Hibrise Technology Pvt Ltd Chennai.\n \n Developers \n \n \t KURAISA FARJANA \n \t MANOJ KUMAR \n \t MURALI KRISHNAN \n \t PALANIAPPAN\n \t PEER MOHAMED THABIB \n \t TAMIL MANI \n \n UI Designer: \t ARIESH \n \n For feedbacks: \n\n \t feedback@hibrise.com";
    myTextView.textAlignment = NSTextAlignmentLeft;
    myTextView.backgroundColor = [UIColor clearColor];
    myTextView.font =[UIFont fontWithName:@"Eras Medium ITC" size:15];
    [myTextView setUserInteractionEnabled:NO];
    myTextView.selectedRange = NSMakeRange(2, 0);
   
    [self.view addSubview:background];
    [background addSubview:bgview];
    [bgview addSubview:myTextView];
    [bgview addSubview:button];

}


- (void)HideView:(UIButton*)button
{
    
    [background removeFromSuperview];
    
    
}
@end
