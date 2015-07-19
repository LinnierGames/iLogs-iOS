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
            IBOutlet UIImageView *imageviewCurtain;
            IBOutlet UITableView *tableMap;
        IBOutlet UIView *viewTags;
            IBOutlet UITableView *tableTags;
    
    NSMutableArray *arrayStories;
    NSDictionary *dicStories;
    NSMutableArray *arrayTags;
    
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

#pragma mark Return Functions > Pre-Defined Functions (TABLE VIEW)

//Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch ([tableView tag]) {
        case 1: //Map
            return 1; break;
        case 2: //Stories
            return [[dicStories allKeys] count]; break;
        case 3: //Tags
            return 1; break;
        default:
            return 0; break;
            
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch ([tableView tag]) {
        case 1: //Map
            return @""; break;
        case 2: //Stories
            return [[dicStories allKeys] objectAtIndex: section]; break;
        case 3: //Tags
            return @""; break;
        default:
            return nil; break;
            
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch ([tableView tag]) {
        case 1: //Map
            return @""; break;
        case 2: //Stories
            return @""; break;
        case 3: //Tags
            return @""; break;
        default:
            return nil; break;
            
    }
    
}

//Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch ([tableView tag]) {
        case 1: //Map
            return 10; break;
        case 2: //Stories
            return [[dicStories objectForKey: [[dicStories allKeys] objectAtIndex: section]] count]; break;
        case 3: //Tags
            return 10; break;
        default:
            return 0; break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: //Map
            return 44; break;
        case 2: //Stories
            return 38; break;
        case 3: //Tags
            return 38; break;
        default:
            return 44; break;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: { //Map
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
            //Customize Cell
            
            return cell; break;
            
        } case 2: { //Stories
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
            //Customize Cell
            
            return cell; break;
            
        } case 3: { //Tags
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
            //Customize Cell
            
            return cell; break;
            
        } default:
            return nil; break;
            
    }
    
}

#pragma mark - Void's

- (void)reloadTable {
    [self reloadTableForTable: currentView];
    
}

- (void)reloadTableForTable:(CDSelectedMap)map {
    switch (map) {
        case CTMapView:
            [tableMap reloadData];
            break;
        case CTStoriesView:
            dicStories = [UniversalFunctions STORIES_returnGroupedStories];
            [tableStories reloadData];
            break;
        case CTTags:
            [tableTags reloadData];
            break;
            
    }
    
}

- (void)statusBarTappedAction:(NSNotification *)notification {
    [self dismissViewControllerAnimated: YES completion: ^{}];
    
}

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
                if (currentView == CTMapView) { //To Tags
                    [viewMap setUserInteractionEnabled: NO];
                    [imageviewCurtain setAlpha: 0.4];
                    [viewTags setAlpha: 1];
                    [viewTags setTransform: CGAffineTransformMakeScale( 1, 1)];
                    [self.navigationItem setPrompt: @"Tags"];
                    
                } else { //To Map
                    [viewMap setUserInteractionEnabled: YES];
                    [imageviewCurtain setAlpha: 0];
                    [viewStories setAlpha: 0];
                    [viewStories setTransform: CGAffineTransformMakeScale( 0.8, 0.8)];
                    [self.navigationItem setPrompt: @"Prompt"];
                    
                }
                currentView++;
                
            }
            break;
            
        } case UISwipeGestureRecognizerDirectionRight: {
            if (currentView == CTMapView || currentView == CTTags) {
                [viewMap setTransform: CGAffineTransformTranslate( viewMap.transform, self.view.frame.size.width -offset, 0)];
                if (currentView == CTMapView) { //To Stories
                    [viewMap setUserInteractionEnabled: NO];
                    [imageviewCurtain setAlpha: 0.4];
                    [viewStories setAlpha: 1];
                    [viewStories setTransform: CGAffineTransformMakeScale( 1, 1)];
                    [self.navigationItem setPrompt: @"Stories"];
                    
                } else { //To Map
                    [viewMap setUserInteractionEnabled: YES];
                    [imageviewCurtain setAlpha: 0];
                    [viewTags setAlpha: 0];
                    [viewTags setTransform: CGAffineTransformMakeScale( 0.8, 0.8)];
                    [self.navigationItem setPrompt: @"Prompt"];
                    
                }
                currentView--;
                
            }
            break;
            
        }
            
        default:
            break;
    }
    [UIView commitAnimations];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayStories = [NSMutableArray new];
    dicStories = [NSDictionary new];
    arrayTags = [NSMutableArray new];
    
    currentView = CTMapView;
    [viewStories setAlpha: 0];
    [viewStories setTransform: CGAffineTransformMakeScale( 0.85, 0.85)];
    [viewTags setAlpha: 0];
    [viewTags setTransform: CGAffineTransformMakeScale( 0.85, 0.85)];
    [viewMap.layer setShadowOpacity: 1];
    [viewMap.layer setShadowRadius: 12];
    [viewMap.layer setShadowColor: [[UIColor blackColor] CGColor]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [[UniversalVariables globalVariables] setViewController: self asCurrentView: self];
    
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
