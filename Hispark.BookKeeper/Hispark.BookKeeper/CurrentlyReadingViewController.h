//
//  CurrentlyReadingViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 08/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "BookSet.h"
#import "ViewingNotesViewController.h"
#import "CoreDataManager.h"

@interface CurrentlyReadingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic)IBOutlet UIBarButtonItem *sidebarButton;


@end
