//
//  tablefriendslistViewController.h
//  Book Keeper
//
//  Created by bsauniv22 on 11/04/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GrpList.h"
#import "FriendsList.h"
#import "CoreDataManager.h"

@interface tablefriendslistViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) NSString * groupid;
@property(nonatomic,retain)NSString *idstr;
@end
