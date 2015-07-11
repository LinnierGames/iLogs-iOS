//
//  DIaryMapViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DiaryMapViewController.h"

typedef NS_ENUM(int, CDSelectedMap) {
    CTStoriesView = 0,
    CTMapView = 1,
    CTTags = 2
    
};

@interface DiaryMapViewController () {
    CDSelectedMap currentView;
        IBOutlet UIView *viewCenter;
        IBOutlet UIView *viewStories;
        IBOutlet UIView *viewTags;
    
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
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft: {
            if (currentView == CTMapView || currentView == CTStoriesView) {
                [viewCenter setTransform: CGAffineTransformTranslate( viewCenter.transform, -self.view.frame.size.width, 0)];
                currentView++;
                
            }
            break;
            
        } case UISwipeGestureRecognizerDirectionRight: {
            if (currentView == CTMapView || currentView == CTTags) {
                [viewCenter setTransform: CGAffineTransformTranslate( viewCenter.transform, self.view.frame.size.width, 0)];
                currentView--;
                
            }
            break;
            
        }
            
        default:
            break;
    }
    [UIView commitAnimations];
    
    NSLog( @"%d", currentView);
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    currentView = CTMapView;
    
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
