//
//  fbfriendlistViewController.h
//  Book Keeper
//
//  Created by bsauniv22 on 10/04/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UserName.h"
#import "GrpList.h"
#import "FriendsList.h"
#import "CoreDataManager.h"

@interface fbfriendlistViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *addinggroup;
}
@property (weak, nonatomic) IBOutlet UILabel *inputlabel;
@property (weak, nonatomic) IBOutlet UILabel *inputlabel1;

@property(strong,nonatomic)UIActionSheet *selectionsheet;
@property(retain,nonatomic)UIPickerView *datapick;
@property NSString *grpid;
@property NSString *str;
@property NSString *str1;
@end
