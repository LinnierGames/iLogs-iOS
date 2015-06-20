//
//  UICustomTableViewCell.m
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UICustomTableViewCell.h"

@implementation UICustomTableViewCell
@synthesize delegate;

#pragma mark - Return Functions

+ (UICustomTableViewCell *)cellType:(CDUICustomTableViewCells)cellType {
    return [[[NSBundle mainBundle] loadNibNamed: @"UICustomTableViewCell" owner: self options: NULL] objectAtIndex: cellType];
    
}

#pragma mark - Void's

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - IBActions

- (IBAction)pressButton:(id)sender {
    if ([delegate respondsToSelector: @selector( customCell:buttonPressed:)])
        [delegate customCell: self buttonPressed: sender];
    
}

#pragma mark - View Lifecycle

- (void)awakeFromNib {
    // Initialization code
}

@end
