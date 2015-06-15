//
//  ViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/14/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "ViewController.h"

#import "DiaryTabBarViewController.h"

@interface ViewController () {
    DiaryTabBarViewController *viewDiary;
    
}

@end

@implementation ViewController

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

#pragma mark - Void's

#pragma mark - IBActions

- (IBAction)pressDiary:(id)sender {
    [self presentViewController: viewDiary animated: YES completion: ^{ }];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    viewDiary = [[[NSBundle mainBundle] loadNibNamed: @"DiaryTabBarViewController" owner: self options: NULL] objectAtIndex: 0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
