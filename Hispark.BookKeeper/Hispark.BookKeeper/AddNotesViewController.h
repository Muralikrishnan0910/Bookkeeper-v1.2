//
//  AddNotesViewController.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 07/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AddNotesViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;

@property (weak, nonatomic) IBOutlet UITextView *addNotesTextView;

@property (nonatomic,strong)NSString *bookname;

@property (nonatomic,strong)NSString *authorname;


@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

- (IBAction)btn_BarBackButton:(id)sender;



- (IBAction)btn_savenotes:(id)sender;

- (IBAction)btn_posttoFB:(id)sender;
@end
