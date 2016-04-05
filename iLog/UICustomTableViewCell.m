//
//  UICustomTableViewCell.m
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UICustomTableViewCell.h"

#import <PureLayout.h>

static CGFloat kLabelHorizontalInsets = 15.0;
static CGFloat kLabelVerticalInsets = 10.0;

@interface UICustomTableViewCell () {
    BOOL didSetupConstraints;
    
}

@end

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

- (void)updateConstraints {
    if (!didSetupConstraints) {
        [NSLayoutConstraint autoSetPriority: UILayoutPriorityRequired forConstraints: ^{
            [self.labelTitle autoSetContentCompressionResistancePriorityForAxis: ALAxisVertical];
            [self.labelSubtitle autoSetContentCompressionResistancePriorityForAxis: ALAxisVertical];
            
        }];
        
        [self.labelTitle autoPinEdgeToSuperviewEdge: ALEdgeTop withInset: kLabelVerticalInsets];
        [self.labelTitle autoPinEdgeToSuperviewEdge: ALEdgeLeading withInset: kLabelHorizontalInsets];
        [self.labelTitle autoPinEdgeToSuperviewEdge: ALEdgeTrailing withInset: kLabelHorizontalInsets];
        
        [self.labelSubtitle autoPinEdge: ALEdgeTop toEdge: ALEdgeBottom ofView: self.labelTitle withOffset: 10 relation: NSLayoutRelationGreaterThanOrEqual];
        
        [self.labelSubtitle autoPinEdgeToSuperviewEdge: ALEdgeLeading withInset: kLabelHorizontalInsets];
        [self.labelSubtitle autoPinEdgeToSuperviewEdge: ALEdgeTrailing withInset: kLabelHorizontalInsets];
        [self.labelSubtitle autoPinEdgeToSuperviewEdge: ALEdgeBottom withInset: kLabelVerticalInsets];
        
        didSetupConstraints = true;
        
    }
    
    [super updateConstraints];
    
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
