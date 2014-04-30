//
//  CordataFactory.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CordataFactory : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator ;

@end
