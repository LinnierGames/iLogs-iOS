//
//  EntryViewController.h
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EntryViewConrollerDelegate;

@interface EntryViewController : UIViewController

@property ( assign) id< EntryViewConrollerDelegate> delegate;

+ (UINavigationController *)newEntryWithDelegate:(id< EntryViewConrollerDelegate>)delegateValue;
+ (UINavigationController *)modifyEntry:(NSArray *)arrayEntry delegate:(id< EntryViewConrollerDelegate>)delegateValue;

@end

@protocol EntryViewConrollerDelegate <NSObject>

@optional
- (void)entryViewController:(EntryViewController *)entry didFinishWithEntry:(const NSArray *)array;

@end
