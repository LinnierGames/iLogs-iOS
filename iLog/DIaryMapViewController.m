//
//  DIaryMapViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DIaryMapViewController.h"

@interface DiaryMapViewController () {
    IBOutlet UIView *viewCenter;
    
}

@end

@implementation DiaryMapViewController

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

#pragma mark - Void's

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - IBActions

- (IBAction)panScreenEdge:(UISwipeGestureRecognizer *)sender {
    [UIView beginAnimations: NULL context: nil];
    [UIView setAnimationDuration: 0.35];
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
        [viewCenter setTransform: CGAffineTransformTranslate( viewCenter.transform, -self.view.frame.size.width, 0)];
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight)
        [viewCenter setTransform: CGAffineTransformTranslate( viewCenter.transform, self.view.frame.size.width, 0)];
    [UIView commitAnimations];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
