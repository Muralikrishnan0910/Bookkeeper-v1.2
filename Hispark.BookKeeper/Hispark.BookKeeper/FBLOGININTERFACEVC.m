//
//  ViewController.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "FBLOGININTERFACEVC.h"
#import "SWRevealViewController.h"

@interface FBLOGININTERFACEVC ()

@property(nonatomic,strong) CoreDataManager *coredatamanagerobj;
@property(nonatomic,strong) SWRevealViewController *swrealviewobj;

@end

@implementation FBLOGININTERFACEVC

- (void)viewDidLoad
{
    self.coredatamanagerobj = [[CoreDataManager alloc]init];
    
    self.swrealviewobj = [[SWRevealViewController alloc]init];
    
    self.managedObjectContext = self.coredatamanagerobj.managedObjectContext;
    
    NSArray* permission = [NSArray arrayWithObjects:@"basic_info",
                           @"email", nil];
    
    FBLoginView *loginView = [[FBLoginView alloc]
                              initWithReadPermissions:permission];
    
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 400);
    [self.view addSubview:loginView];
    loginView.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    NSLog(@"UserName--> %@",user.name);
    
    NSUserDefaults *currentUserName = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [currentUserName setObject:user.name forKey:@"LoggedInUserName"];
    [currentUserName synchronize];
    
    NSString *LoggedinName = [currentUserName stringForKey:@"LoggedInUserName"];
    
    if (![LoggedinName isEqualToString:@""])
    {
        [self CheckUserNameAlreadyExist];
    }
}

-(void)CheckUserNameAlreadyExist
{
    NSArray *DataCollection = [[NSArray alloc]init];
    DataCollection = [self.coredatamanagerobj GetAllUserNames];
    NSUserDefaults *currentUserName = [NSUserDefaults standardUserDefaults];
    
    NSString *user = [currentUserName stringForKey:@"LoggedInUserName"];
    NSLog(@"UserName %@",user);
   
   if (DataCollection.count != 0)
   {
       for (int i=0; i<[DataCollection count]; i++)
        {
            NSManagedObject *obj=[DataCollection objectAtIndex:i];
            
            if (![user isEqualToString:[obj valueForKey:@"cuserName"]])
            {

                NSLog(@"IncommingName %@",[obj valueForKey:@"cuserName"]);
                
                UserName *addUser = [NSEntityDescription insertNewObjectForEntityForName:@"UserName" inManagedObjectContext:self.managedObjectContext];
                NSUserDefaults *currentUserName = [NSUserDefaults standardUserDefaults];
                
                NSString *LoggedinName = [currentUserName
                                          stringForKey:@"LoggedInUserName"];
                
                addUser.cuserName = LoggedinName;
                
                
                
                NSError *error;
                if (![self.managedObjectContext save:&error])
                {
                    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
                }
                
                [self NavigateToCurrentlyReadingViewController];
                

            }
            
            else
            {
                [self NavigateToCurrentlyReadingViewController];
            }
           
        }
   }
   else
   {
       UserName *addUser = [NSEntityDescription insertNewObjectForEntityForName:@"UserName" inManagedObjectContext:self.managedObjectContext];
       NSUserDefaults *currentUserName = [NSUserDefaults standardUserDefaults];
       
       NSString *LoggedinName = [currentUserName
                                 stringForKey:@"LoggedInUserName"];
       
       addUser.cuserName = LoggedinName;
       
       NSError *error;
       if (![self.managedObjectContext save:&error]) {
           NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
       }
        [self NavigateToCurrentlyReadingViewController];
   }


}


// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    //self.statusLabel.text = @"You're logged in as";
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
//    self.profilePictureView.profileID = nil;
    
//    self.statusLabel.text= @"You're not logged in!";
}


- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}


-(void)NavigateToCurrentlyReadingViewController
{
    self.swrealviewobj = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self presentViewController:self.swrealviewobj animated:NO completion:^void{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
