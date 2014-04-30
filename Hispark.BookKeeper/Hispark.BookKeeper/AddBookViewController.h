//
//  AddBookViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "BookSet.h"
#import "CoreDataManager.h"

@interface AddBookViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UITextFieldDelegate>



@property (weak, nonatomic) IBOutlet UITextField *BookNameTextField;


@property (weak, nonatomic) IBOutlet UITextField *AuthorNameTextField;


@property (weak, nonatomic) IBOutlet UITextField *TotalPagesTextField;

@property (weak, nonatomic) IBOutlet UILabel *DateResultLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn_startDate;

- (IBAction)btn_startDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_saveBookToDatabase;

- (IBAction)btn_saveBookToDatabase:(id)sender;

@property (nonatomic, strong) UIActionSheet *dateActionSheet;
@property (nonatomic, retain) UIDatePicker *datePicker;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@end
