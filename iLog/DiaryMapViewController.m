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
        IBOutlet UIView *viewStories;
            IBOutlet UITableView *tableStories;
        IBOutlet UIView *viewMap;
            IBOutlet UITableView *tableMap;
        IBOutlet UIView *viewTags;
            IBOutlet UITableView *tableTags;
    
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
    CGFloat offset = 26;
    [UIView beginAnimations: NULL context: nil];
    [UIView setAnimationDuration: 0.35];
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft: {
            if (currentView == CTMapView || currentView == CTStoriesView) {
                [viewMap setTransform: CGAffineTransformTranslate( viewMap.transform, -self.view.frame.size.width +offset, 0)];
                if (currentView == CTMapView) {
                    [viewMap setUserInteractionEnabled: NO];
                    [viewTags setAlpha: 1];
                    
                } else {
                    [viewMap setUserInteractionEnabled: YES];
                    [viewStories setAlpha: 0];
                    
                }
                currentView++;
                
            }
            break;
            
        } case UISwipeGestureRecognizerDirectionRight: {
            if (currentView == CTMapView || currentView == CTTags) {
                [viewMap setTransform: CGAffineTransformTranslate( viewMap.transform, self.view.frame.size.width -offset, 0)];
                if (currentView == CTMapView) {
                    [viewMap setUserInteractionEnabled: NO];
                    [viewStories setAlpha: 1];
                    
                } else {
                    [viewMap setUserInteractionEnabled: YES];
                    [viewTags setAlpha: 0];
                    
                }
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
    [viewStories setAlpha: 0];
    [viewTags setAlpha: 0];
    
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
