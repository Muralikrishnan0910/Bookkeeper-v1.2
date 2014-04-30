//
//  UpdateViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 07/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataManager.h"

@interface UpdateViewController : UIViewController <UITextFieldDelegate>



- (IBAction)btn_Bar_BackButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *booKNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalNumberOfPages;

@property (weak, nonatomic) IBOutlet UITextField *pagesCompletedTextField;

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;

@property(nonatomic,strong)NSString *bookName;

@property(nonatomic,strong)NSString *authorName;

@property(nonatomic,strong)NSNumber *TotalPages;

@property(nonatomic,strong)NSDate *startDate;

@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;

- (IBAction)btn_UpdateAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

@end
