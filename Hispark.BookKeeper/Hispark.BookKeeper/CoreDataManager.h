//
//  CoreDataManager.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import "CordataFactory.h"

@interface CoreDataManager : CordataFactory

-(NSArray *)GetAllUserNames;

-(NSArray *)GetAllBooks;

-(NSMutableArray *)GetAllCompletedBooks;

-(NSMutableArray *)GetAllCurrentlyReading;

-(void)UpdatePagesField:(NSString *)bookname SelectedAuthor:(NSString *) selectedauthorname PageEntered:(NSString *)updatepage;

-(void)StoringNotesForCorrespondingBook :(NSString *)selectedbookname SelectedAuthorName :(NSString *) selectedauthorname Notes:(NSMutableArray *)notes;
-(NSArray *)GetAllCommonFriends;
-(NSArray *)GetalladdedCommonFriends;
-(NSArray *)GetAllGroups;
-(NSArray*)GetalladdedGroups;
@end
