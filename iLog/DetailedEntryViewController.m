//
//  DetailedEntryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 3/21/16.
//  Copyright © 2016 Erick Sanchez. All rights reserved.
//

#import "DetailedEntryViewController.h"

#import "EntryViewController.h"
#import "DiaryController.h"

@interface DetailedEntryViewController () < EntryViewConrollerDelegate>

@property ( nonatomic, retain) NSMutableArray *arrayM;

@end

@implementation DetailedEntryViewController
@synthesize arrayM;

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

+ (UINavigationController *)detailEntry:(NSArray *)arrayEntry delegate:(id< DetailedEntryViewControllerDelegate>)delegateValue {
    return [[UINavigationController alloc] initWithRootViewController: [[DetailedEntryViewController alloc] initWithEntry: arrayEntry delegate: delegateValue]];
    
}

- (id)initWithEntry:(NSArray *)arrayEntry delegate:(id< DetailedEntryViewControllerDelegate>)delegateValue {
    self = [super initWithNibName: @"DetailedEntryViewController" bundle: [NSBundle mainBundle]];
    
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit target: self action: @selector( pressNavRight:)]];
    [self setHidesBottomBarWhenPushed: YES];
    
    arrayM = [[NSMutableArray alloc] initWithArray: arrayEntry];
    
    return self;
    
}

#pragma mark - Void's

#pragma mark - IBActions

- (void)pressNavRight:(id)sender {
    [self presentViewController: [EntryViewController modifyEntry: arrayM delegate: self] animated: YES];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [self setTitle: [arrayM objectEntry_subject]];
    
}

@end
