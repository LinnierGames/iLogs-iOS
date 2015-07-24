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

@interface DiaryMapViewController () < UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate> {
    CDSelectedMap currentView;
        IBOutlet UIView *viewStories;
            IBOutlet UITableView *tableStories;
        IBOutlet UIView *viewMap;
            IBOutlet UIImageView *imageviewCurtain;
            IBOutlet UITableView *tableMap;
        IBOutlet UIView *viewTags;
            IBOutlet UITableView *tableTags;
    
    NSMutableArray *arrayStories;
//    NSDictionary *dicStories;
    NSMutableArray *arrayTags;
    
    NSMutableArray *array;
    
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
            return [arrayStories count]; break;
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
            return [[[[arrayStories objectAtIndex: section] lastObject] objectForKey: @"diary"] objectDiary_title]; break;
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
            return [[arrayStories objectAtIndex: section] count] -1; break;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: //Map
            return NO; break;
        case 2: //Stories
            return YES; break;
        case 3: //Tags
            return YES; break;
        default:
            return NO; break;
            
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
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"cell"];
            //Customize Cell
            NSArray *arrayStory = [[arrayStories objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
            
            [cell.textLabel setText: [arrayStory objectStory_title]];
            [cell.detailTextLabel setText: [arrayStory objectStory_description]];
            
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

- (void)reloadData {
    [self reloadTableForTable: CTMapView];
    [self reloadTableForTable: CTStoriesView];
    [self reloadTableForTable: CTTags];
    
}

- (void)reloadTable {
    [self reloadTableForTable: currentView];
    
}

- (void)reloadTableForTable:(CDSelectedMap)map {
    switch (map) {
        case CTMapView:
            [tableMap reloadData];
            break;
        case CTStoriesView:
            arrayStories = [NSMutableArray arrayWithArray: [UniversalFunctions STORIES_returnGroupedStories]];
            [tableStories reloadData];
            break;
        case CTTags:
            [tableTags reloadData];
            break;
            
    }
    
}

- (void)reloadLayout {
    switch (currentView) {
        case CTMapView: {
            [self.navigationItem setPrompt: @"Prompt"];
            [self.navigationItem setRightBarButtonItem: nil animated: YES];
            [self.navigationItem setLeftBarButtonItem: nil animated: YES];
            break;
            
        } case CTStoriesView: {
            [self.navigationItem setPrompt: @"Stories"];
            [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action: @selector( pressedNavRight:)] animated: YES];
            [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit target: self action: @selector( pressedNavLeft:)] animated: YES];
            break;
            
        } case CTTags: {
            [self.navigationItem setPrompt: @"Tags"];
            break;
            
        }
            
    }
    
}

- (void)statusBarTappedAction:(NSNotification *)notification {
    [self dismissViewControllerAnimated: YES completion: ^{}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark Void's > Pre-Defined Functions (TABLE VIEW)

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: {
            break;
            
        } case 2: {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [[UniversalVariables globalVariables] STORIES_deleteForStory: [[arrayStories objectAtIndex: indexPath.section] objectAtIndex: indexPath.row]];
                [self reloadTable];
                
            }
            break;
            
        } case 3: {
            break;
            
        }
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ALERT VIEW)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (currentView) {
        case CTMapView: {
            break;
            
        } case CTStoriesView: {
            if ([alertView tag] == 1) { //Adding Story
                if (buttonIndex == 1) {
                    array = [NSMutableArray arrayNEWStoryWithTitle: [[[alertView textFieldAtIndex: 0] text] stringByReformatingForSQLQuries] description: [[[alertView textFieldAtIndex: 1] text] stringByReformatingForSQLQuries]];
                    UIActionSheet *actionDiaries = [[UIActionSheet alloc] initWithTitle: @"New Story" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: nil];
                    [actionDiaries setTag: 1];
                    NSArray *arrayDiaries = [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries];
                    for (NSArray *arrayDiary in arrayDiaries)
                        [actionDiaries addButtonWithTitle: [arrayDiary objectDiary_title]];
                    [actionDiaries showInView: self.view];
                    
                }
                
            }
            break;
            
        } case CTTags: {
            break;
            
        }
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ACTION SHEET)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (currentView) {
        case CTMapView: {
            break;
            
        } case CTStoriesView: {
            if ([actionSheet tag] == 1) { //New Story > Select Diary
                if (buttonIndex != 0) {
                    buttonIndex -= 1;
                    NSArray *arrayDiaries = [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries];
                    [[array optionsDictionary] setValue: [arrayDiaries objectAtIndex: buttonIndex] forKey: @"diary"];
                    [[UniversalVariables globalVariables] STORIES_writeNewForStory: array];
                    [self reloadTable];
                    
                }
                
            }
            break;
            
        } case CTTags: {
            break;
            
        }
            
    }
    
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
                    [imageviewCurtain setUserInteractionEnabled: YES];
                    [imageviewCurtain setAlpha: 0.4];
                    [viewTags setAlpha: 1];
                    [viewTags setTransform: CGAffineTransformMakeScale( 1, 1)];
                    
                } else { //To Map
                    [imageviewCurtain setUserInteractionEnabled: NO];
                    [imageviewCurtain setAlpha: 0];
                    [viewStories setAlpha: 0];
                    [viewStories setTransform: CGAffineTransformMakeScale( 0.8, 0.8)];
                    
                }
                currentView++;
                
            }
            break;
            
        } case UISwipeGestureRecognizerDirectionRight: {
            if (currentView == CTMapView || currentView == CTTags) {
                [viewMap setTransform: CGAffineTransformTranslate( viewMap.transform, self.view.frame.size.width -offset, 0)];
                if (currentView == CTMapView) { //To Stories
                    [imageviewCurtain setUserInteractionEnabled: YES];
                    [imageviewCurtain setAlpha: 0.4];
                    [viewStories setAlpha: 1];
                    [viewStories setTransform: CGAffineTransformMakeScale( 1, 1)];
                    
                } else { //To Map
                    [imageviewCurtain setUserInteractionEnabled: NO];
                    [imageviewCurtain setAlpha: 0];
                    [viewTags setAlpha: 0];
                    [viewTags setTransform: CGAffineTransformMakeScale( 0.8, 0.8)];
                    
                }
                currentView--;
                
            }
            break;
            
        }
            
        default:
            break;
    }
    [UIView commitAnimations];
    [self reloadLayout];
    
}

- (IBAction)pressedNavRight:(id)sender {
    switch (currentView) {
        case CTMapView: {
            break;
            
        } case CTStoriesView: {
            if ([[UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries] count] > 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Story" message: @"enter the title and description" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Next", nil];
                [alert setTag: 1];
                [alert setAlertViewStyle: UIAlertViewStyleLoginAndPasswordInput];
                [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
                [[alert textFieldAtIndex: 0] setAutocorrectionType: UITextAutocorrectionTypeYes];
                [[alert textFieldAtIndex: 1] setAutocapitalizationType: UITextAutocapitalizationTypeSentences];
                [[alert textFieldAtIndex: 1] setAutocorrectionType: UITextAutocorrectionTypeYes];
                [[alert textFieldAtIndex: 1] setSecureTextEntry: NO];
                [alert show];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Story" message: @"you must have at least one diary to add a story. Stories belong to a diary" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
                [alert show];
                
            }
            break;
            
        } case CTTags: {
            break;
            
        }
            
    }
    
}

- (IBAction)pressedNavLeft:(id)sender {
    switch (currentView) {
        case CTMapView: {
            break;
            
        } case CTStoriesView: {
            [tableStories setEditing: !tableStories.isEditing animated: YES];
            break;
            
        } case CTTags: {
            break;
            
        }
            
    }
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayStories = [NSMutableArray new];
//    dicStories = [NSDictionary new];
    arrayTags = [NSMutableArray new];
    
    array = [NSMutableArray new];
    
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
    [self reloadData];
    
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
