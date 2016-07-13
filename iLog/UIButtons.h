//
//  UIButtons.h
//  iLogs - Universal iOS
//
//  Created by Erick Sanchez on 6/2/16.
//  Copyright © 2016 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIButtonsDelegate;

typedef enum : NSUInteger {
    CTButtonsAdd,
    CTButtonsCompose
    
} CDButtonsType;

@interface UIButtons : UIView

@property ( assign) id< UIButtonsDelegate> delegate;

+ (instancetype)buttonWithType:(CDButtonsType)button withDelegate:(id< UIButtonsDelegate>)delegateValue;
//- (id)initWithDelegate:(id< UIButtonsDelegate>)delegateValue;

@end

@protocol UIButtonsDelegate <NSObject>

@optional
- (void)buttonTapped:(UIButtons *)button;
- (void)buttonLongTap:(UIButtons *)button;

@end