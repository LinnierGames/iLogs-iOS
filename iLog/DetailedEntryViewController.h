//
//  DetailedEntryViewController.h
//  iLog
//
//  Created by Erick Sanchez on 3/21/16.
//  Copyright © 2016 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Entry;

@protocol DetailedEntryViewControllerDelegate;

@interface DetailedEntryViewController : UIViewController

@property ( nonatomic, retain) Entry *entry;

+ (UINavigationController *)detailEntry:(Entry *)entryValue delegate:(id< DetailedEntryViewControllerDelegate>)delegateValue;

- (id)initWithEntry:(Entry *)entryValue delegate:(id< DetailedEntryViewControllerDelegate>)delegateValue;

@end

@protocol DetailedEntryViewControllerDelegate <NSObject>

@optional
- (void)detailedEntryViewController:(DetailedEntryViewController *)entry didFinishWithEntry:(const NSArray *)array;

@end
