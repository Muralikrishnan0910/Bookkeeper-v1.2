//
//  FriendsList.h
//  Book Keeper
//
//  Created by bsauniv22 on 25/04/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FriendsList : NSManagedObject

@property (nonatomic, retain) NSString * friendsname;
@property (nonatomic, retain) NSString * friendsid;

@end
