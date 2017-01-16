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

@interface DetailedEntryViewController () < EntryViewConrollerDelegate> {
    IBOutlet UIScrollView *scrollMedia;
    IBOutlet UIWebView *webview;
    
}

@end

@implementation DetailedEntryViewController

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

+ (UINavigationController *)detailEntry:(Entry *)entryValue delegate:(id< DetailedEntryViewControllerDelegate>)delegateValue {
    return [[UINavigationController alloc] initWithRootViewController: [[DetailedEntryViewController alloc] initWithEntry: entryValue delegate: delegateValue]];
    
}

- (id)initWithEntry:(Entry *)entryValue delegate:(id< DetailedEntryViewControllerDelegate>)delegateValue {
    self = [super initWithNibName: @"DetailedEntryViewController" bundle: [NSBundle mainBundle]];
    
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit target: self action: @selector( pressNavRight:)]];
    [self setHidesBottomBarWhenPushed: YES];
    
    self.entry = entryValue;
    
    return self;
    
}

#pragma mark - Void's

#pragma mark Void's > Pre-Defined Functions (ENTRY VIEW CONTROLLER)

- (void)entryViewController:(EntryViewController *)entry didFinishWithEntry:(const Entry *)entry {
    
}

#pragma mark - IBActions

- (void)pressNavRight:(id)sender {
    [self presentViewController: [EntryViewController modifyEntry: self.entry delegate: self] animated: YES];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self.navigationController action: @selector( popViewControllerAnimated:)]];
    
    [webview.scrollView setContentOffset: CGPointMake( 0, 0)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self setTitle: self.entry.subject];
    
}

- (void)viewDidLayoutSubviews {
    if (UIInterfaceOrientationIsLandscape( self.interfaceOrientation)) {
        [webview setFrame: CGRectZero];
        CGRect rect = self.view.frame;
        rect.size.height -= 32;
        rect.origin.y += 32;
        [scrollMedia setFrame: rect];
        
        [webview setHidden: YES];
        
    } else
        [webview setHidden: NO];
    
}

@end
