//
//  ViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/14/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "ViewController.h"

#import "DiaryViewController.h"

@interface ViewController () {
    DiaryViewController *viewDiary;
    
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
    [self presentViewController: [[NSBundle mainBundle] loadNibNamed: @"DiaryViewController" owner: self options: NULL][0] animated: YES completion: ^{ }];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    viewDiary = [[DiaryViewController alloc] initWithNibName: @"DiaryViewController" bundle: [NSBundle mainBundle]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
