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

@interface UITableViewModuleViewController : UIViewController

@property ( nonatomic, retain) NSMutableArray *arrayM;
@property ( assign, readonly) CDTableViewModule module;

- (id)initWithContent:(id)value;
- (id)initWithModule:(CDTableViewModule)moduleValue withContent:(NSArray *)arrayValue;

@end
