//
//  CurrentlyReadingViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "CoreDataManager.h"
#import "currentlyReadingCustomCell.h"
#import "BookSet.h"
#import "AddNotesViewController.h"
#import "UpdateViewController.h"

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic)IBOutlet UIBarButtonItem *sidebarButton;
-(IBAction)AddnotesnavigateAction:(id)sender;

-(IBAction)UpdatenavigateAction:(id)sender;




@end
