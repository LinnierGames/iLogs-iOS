//
//  UITableViewModuleViewController.h
//  iLog
//
//  Created by Erick Sanchez on 6/25/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CDTableViewModule) {
    CTTableViewModule,
    CTTableViewDiaries,
    CTTableViewTags
    
};

@protocol UITableViewModuleViewController;

@interface UITableViewModuleViewController : UIViewController

@property ( nonatomic, retain) NSMutableArray *arrayM;
@property ( assign, readonly) CDTableViewModule module;

@property ( assign) id<UITableViewModuleViewController > delegate;

- (id)initWithModule:(CDTableViewModule)moduleValue;
- (id)initWithModule:(CDTableViewModule)moduleValue withContent:(id)content;
+ (UINavigationController *)allocWithModule:(CDTableViewModule)moduleValue;
+ (UINavigationController *)allocWithModule:(CDTableViewModule)moduleValue withContent:(id)content;

@end

@protocol UITableViewModuleViewController <NSObject>
@optional
- (void)tableViewModule:(UITableViewModuleViewController *)tableViewModule didFinishWithChanges:(NSDictionary *)dictionary;

@end
