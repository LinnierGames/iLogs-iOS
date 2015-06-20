//
//  UICustomTableViewCell.h
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CDUICustomTableViewCells) {
    CTUICustomTableViewCellTextField = 0,
    CTUICustomTableViewCellTextView = 1,
    CTUICustomTableViewCellTitleTextView = 2,
    /*app-Diary*/
    CTUICustomTableViewCellDiaryEntryAttributes = 3
    
};

@protocol UICustomTableViewCellDelegate;

@interface UICustomTableViewCell : UITableViewCell

@property ( nonatomic, retain) IBOutlet UILabel *labelTitle;
@property ( nonatomic, retain) IBOutlet UILabel *labelSubtitle;
@property ( nonatomic, retain) IBOutlet UITextField *textfield;
@property ( nonatomic, retain) IBOutlet UITextView *textview;

@property ( assign) id< UICustomTableViewCellDelegate>  delegate;

+ (UICustomTableViewCell *)cellType:(CDUICustomTableViewCells)cellType;

- (IBAction)pressButton:(id)sender;

@end

@protocol UICustomTableViewCellDelegate <NSObject>

@optional
- (void)customCell:(UICustomTableViewCell *)cell buttonPressed:(id)button;

@end