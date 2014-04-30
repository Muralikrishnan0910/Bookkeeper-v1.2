//
//  currentlyReadingCustomCell.h
//  Hispark.BookKeeper
//
//  Created by Thabib on 06/03/14.
//  Copyright (c) 2014 peer mohamed thabib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface currentlyReadingCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;



@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIButton *btn_addExceprts;


@property (weak, nonatomic) IBOutlet UIButton *btn_UpdateButton;


@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end
