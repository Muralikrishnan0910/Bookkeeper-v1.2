//
//  ViewingNotesViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 08/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookSet.h"

@interface ViewingNotesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) BookSet *selectedbook;

@property(nonatomic,strong) NSMutableArray *selectedbookNotes;



@end
