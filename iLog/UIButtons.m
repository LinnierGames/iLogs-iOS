//
//  UIButtons.m
//  iLogs - Universal iOS
//
//  Created by Erick Sanchez on 6/2/16.
//  Copyright © 2016 Erick Sanchez. All rights reserved.
//

#import "UIButtons.h"

@implementation UIButtons
@synthesize delegate;

#pragma mark - Return Functions

- (id)initWithDelegate:(id)delegateValue {
    self = [super initWithFrame: CGRectMake( 0, 0, 40, 30)];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"misc_toolbarAdd"]];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(tapped:)];
        [self addGestureRecognizer: tapGes];
        UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget: self action:@selector(longPress:)];
        [self addGestureRecognizer: longPressGes];
        
        delegate = delegateValue;
        
    }
    
    return self;
    
}

#pragma mark - Void's

- (void)tapped:(id)sender {
    if ([delegate respondsToSelector: @selector( buttonTapped:)]) {
        [delegate buttonTapped: self];
        
    }
    
}


- (void)longPress:(id)sender {
    if ([delegate respondsToSelector: @selector( buttonLongTap:)])
        if ([sender state] == UIGestureRecognizerStateBegan)
            [delegate buttonLongTap: self];
    
}

#pragma mark - IBActions

#pragma mark - View Lifecycle



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
