//
//  CoreDataManager.m
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager


-(NSArray *)GetAllUserNames
{// initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserName"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    NSLog(@"USERNAME %@",fetchedRecords);
    
    // Returning Fetched Records
    return fetchedRecords;
}

-(NSMutableArray *)GetAllBooks
{// initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Setting Entity to be Queried
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookSet"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    NSLog(@"BookSet %@",fetchedRecords);
    
    
    NSUserDefaults *currentUserName = [NSUserDefaults standardUserDefaults];
    NSString *LoggedinName = [currentUserName stringForKey:@"LoggedInUserName"];
    
    NSMutableArray *currentUserBooks = [[NSMutableArray alloc]init];
    
    for (NSManagedObjectContext *obj in fetchedRecords) {
        if ([LoggedinName isEqualToString:[obj valueForKey:@"cuserName"]])
        {
            [currentUserBooks addObject:obj];
            NSLog(@"Current USER Books %@",currentUserBooks);
        }
    }
    
    
    // Returning Fetched Records
    return currentUserBooks;
}
-(NSArray *)GetAllGroups{
    
    NSFetchRequest *fetchrequest=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entitydesc=[NSEntityDescription entityForName:@"GrpList" inManagedObjectContext:self.managedObjectContext];
    
    [fetchrequest setEntity:entitydesc];
    NSError *error;
    
    NSArray *fetchrecords=[self.managedObjectContext executeFetchRequest:fetchrequest error:&error];

    
    // Returning Fetched Records
    return fetchrecords;
}
-(NSArray *)GetAllCommonFriends{
    
    NSFetchRequest *fetchrequest=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entitydesc=[NSEntityDescription entityForName:@"FriendsList" inManagedObjectContext:self.managedObjectContext];
    
    [fetchrequest setEntity:entitydesc];
    NSError *error;
    
    NSArray *fetchrecords=[self.managedObjectContext executeFetchRequest:fetchrequest error:&error];
    
    
    // Returning Fetched Records
    return fetchrecords;
}
//storing the Note for the particular book user have selected this method is called in Add notes view controller save button action

-(void)StoringNotesForCorrespondingBook :(NSString *)selectedbookname SelectedAuthorName :(NSString *) selectedauthorname Notes:(NSMutableArray *)notes
{
    NSArray *userbookset = [self GetAllBooks];
    
    for (NSManagedObject *obj in userbookset)
    {
        
        if ([selectedbookname isEqualToString:[obj valueForKey:@"bookName"]] && [selectedauthorname isEqualToString:[obj valueForKey:@"authorName"]])
        {
            
            NSArray *notesattributearray = [NSKeyedUnarchiver unarchiveObjectWithData:[obj valueForKey:@"notes" ]];
            NSLog(@"Coredata notes: %@",notesattributearray);
            
            if (notesattributearray==nil) {
                notesattributearray=[[NSArray alloc]init];
            }
            NSMutableSet *set = [NSMutableSet setWithArray:notesattributearray];
            [set addObjectsFromArray:notes];
            NSArray *allnotes = [set allObjects];
            [obj setValue:[NSKeyedArchiver archivedDataWithRootObject:allnotes] forKey:@"notes"];
            
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
    }
    
}


//updating the pagenumber for selected book, this method gets called when we press save button in updateview controller

-(void)UpdatePagesField:(NSString *)bookname SelectedAuthor:(NSString *) selectedauthorname PageEntered:(NSString *)updatepage
{
    NSArray *bookset = [self GetAllBooks];
    
    for (NSManagedObject *obj in bookset)
    {
        
        if ([bookname isEqualToString:[obj valueForKey:@"bookName"]] && [selectedauthorname isEqualToString:[obj valueForKey:@"authorName"]])
        {
            NSNumber *pages = [NSNumber numberWithInteger:[updatepage integerValue]];
            int totalpages = [[obj valueForKey:@"totalPages"] intValue ];
            
            [obj setValue:pages forKey:@"pagesRead"];
            
            if ([pages intValue] == totalpages)
            {
               [obj setValue:[NSNumber numberWithBool:YES] forKey:@"completedBook"] ;
            }
            
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
    }

}


// Method to get the completed Book data this method is get called from completed books Table view ViewController
-(NSMutableArray *)GetAllCompletedBooks
{
    
    NSArray *bookset = [self GetAllBooks];
    
    NSMutableArray *completedbookset = [[NSMutableArray alloc]init];
    
    for (NSManagedObject *obj in bookset)
    {
        BOOL completed = [[obj valueForKey:@"completedBook"] boolValue];
        
        if (completed == YES)
        {
            [completedbookset addObject:obj];
            
        }
    }

    
    return completedbookset;
}


// Method to get the Currently Reading Book data this method is get called from Currently Reading Table view ViewController

-(NSMutableArray *)GetAllCurrentlyReading
{
    
    NSArray *bookset = [self GetAllBooks];
    
    NSMutableArray *completedbookset = [[NSMutableArray alloc]init];
    
    for (NSManagedObject *obj in bookset)
    {
        BOOL completed = [[obj valueForKey:@"completedBook"] boolValue];
        
        if (completed == NO)
        {
            [completedbookset addObject:obj];
            
        }
    }
    
    
    return completedbookset;
}
-(NSArray*)GetalladdedGroups
{
    NSArray *groups=[self GetAllGroups];
    NSMutableArray *addedgroup=[[NSMutableArray alloc ]init];
    for (NSManagedObject *obj in groups) {
        [addedgroup addObject:obj];
    }
    return addedgroup;
}
-(NSArray *)GetalladdedCommonFriends{
    NSArray *friends=[self GetAllCommonFriends];
    NSMutableArray *addedcommonfriends=[[NSMutableArray alloc]init];
    for (NSManagedObject *obj in friends) {
        [addedcommonfriends addObject:obj];
    }
    return addedcommonfriends;
}

@end
