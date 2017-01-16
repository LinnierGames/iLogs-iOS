//
//  EntryViewController.h
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DiaryController.h"

@protocol EntryViewConrollerDelegate;

@interface EntryViewController : UIViewController

@property ( strong, nonatomic) Entry *entry;
@property ( assign) id< EntryViewConrollerDelegate> delegate;

+ (UINavigationController *)newEntryWithDelegate:(id< EntryViewConrollerDelegate>)delegateValue;
+ (UINavigationController *)modifyEntry:(Entry *)entryValue delegate:(id< EntryViewConrollerDelegate>)delegateValue;

- (id)initWithCRUD:(CRUD)value entry:(Entry *)entryValue delegate:(id< EntryViewConrollerDelegate>)delegateValue;

@end

@protocol EntryViewConrollerDelegate <NSObject>

@optional
- (void)entryViewController:(EntryViewController *)entry didFinishWithEntry:(const Entry *)entry;

@end
