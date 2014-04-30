//
//  ViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserName.h"
#import "CoreDataManager.h"
#import <FacebookSDK/FacebookSDK.h>


@interface FBLOGININTERFACEVC : UIViewController <FBLoginViewDelegate>



@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
