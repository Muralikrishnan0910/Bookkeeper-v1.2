//
//  CompletedBooksViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "CoreDataManager.h"
#import "BookSet.h"

@interface CompletedBooksViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak,nonatomic)IBOutlet UIBarButtonItem *sidebarButton;


@end
