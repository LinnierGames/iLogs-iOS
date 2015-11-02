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
    NSIndexPath *selectedIndexPath;
    
    NSMutableArray *arrayStories;
    NSMutableArray *arrayTagGroups;
    
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
            return [arrayTagGroups count]; break;
        default:
            return 0; break;
            
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch ([tableView tag]) {
        case 1: //Map
            return nil; break;
        case 2: //Stories
            return nil; break;
        case 3: { //Tags
            UIView *view = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, CGRectCurrentDevice().size.width, 38)];
            UILabel *labelHeader = [[UILabel alloc] initWithFrame: view.frame];
            [labelHeader setText: [[[[arrayTagGroups objectAtIndex: section] lastObject] objectForKey: @"group"] objectTagGroup_title]];
            [view addSubview: labelHeader];
            
            UILongPressGesture *longPressGes = [[UILongPressGesture alloc] initWithTarget: self action: @selector(pressedHeaderLong:)];
            [longPressGes setTag: section];
            [view addGestureRecognizer: longPressGes];
            
            return view; break;
            
        } default:
            return nil; break;
            
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch ([tableView tag]) {
        case 1: //Map
            return @""; break;
        case 2: //Stories
            return [[[[arrayStories objectAtIndex: section] lastObject] objectForKey: @"diary"] objectDiary_title]; break;
        case 3: //Tags
            return [[[[arrayTagGroups objectAtIndex: section] lastObject] objectForKey: @"group"] objectTagGroup_title]; break;
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
            return 1; break;
        case 2: //Stories
            return [[arrayStories objectAtIndex: section] count] -1; break;
        case 3: //Tags
            return [[arrayTagGroups objectAtIndex: section] count] -1; /*removing the group hash*/ break;
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: //Map
            return NO; break;
        case 2: //Stories
            return NO; break;
        case 3: //Tags
            return YES; break;
        default:
            return NO; break;
            
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: //Map
            return 0; break;
        case 2: //Stories
            return 0; break;
        case 3: //Tags
            return 0; break;
        default:
            return 0; break;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([tableView tag]) {
        case 1: { //Map
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
            //Customize Cell
            [cell.textLabel setText: @"Export Today's Entries, .csv"];
            
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
            NSArray *arrayTag = [[arrayTagGroups objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
            
            [cell.textLabel setText: [arrayTag objectTag_title]];
            
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
            arrayTagGroups = [NSMutableArray arrayWithArray: [UniversalFunctions TAGGROUPS_returnGroupedTags]];
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
            
            UIView *buttonItemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 30)];
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedNavRight:)];
            [buttonItemView addGestureRecognizer:tapGes];
            UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedNavRightLong:)];
            [buttonItemView addGestureRecognizer:longPressGes];
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItemView];
            self.navigationItem.rightBarButtonItem = barItem;
            
            [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit target: self action: @selector( pressedNavLeft:)] animated: YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (currentView) {
        case CTMapView: {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
                    NSString *filePath = [docPath stringByAppendingPathComponent:@"temp.csv"];
                    
                    NSString *stringContents = @"";
                    
                    NSArray *arrayEntries = [UniversalFunctions SQL_returnContentsOfTable: CTSQLEntries];
                    
                    for (NSArray *arrayEntry in arrayEntries) {
                        stringContents = [stringContents stringByAppendingString: [NSString stringWithFormat: @"\"%@\"\r\"%@\"\r\"Date: %@\"\r", [arrayEntry objectEntry_subject], [arrayEntry objectEntry_body], [[arrayEntry objectEntry_date] stringValue: CTCharacterDate]]];
                        
                    }
                    
                    NSError *error;
                    
                    [stringContents writeToFile:filePath
                               atomically:YES
                                 encoding:NSUTF8StringEncoding
                                    error:&error];
                    
                    // check for the error
                    
                    NSURL *url = [NSURL fileURLWithPath:filePath];
                    
                    UIActivityViewController *action = [[UIActivityViewController alloc] initWithActivityItems: @[@"Here lies an export of my diaries", url] applicationActivities:  nil];
                    [action.popoverPresentationController setSourceView: [tableView cellForRowAtIndexPath: indexPath]];
                    [self presentViewController: action animated: YES completion: ^{ }];
                    
                }
            }
            break;
            
        } case CTStoriesView: {
            break;
            
        } case CTTags: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Modifying a Tag" message: @"enter the title" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Save", nil];
            [alert setTag: 2];
            [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
            [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
            [[alert textFieldAtIndex: 0] setAutocorrectionType: UITextAutocorrectionTypeYes];
            array = [[arrayTagGroups objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
            [[alert textFieldAtIndex: 0] setText: [array objectTag_title]];
            [alert show];
            break;
            
        }
            
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    switch ([tableView tag]) {
        case 1: { //Map
            break;
            
        } case 2: { //Stories
            break;
            
        } case 3: { //Tags
            if (sourceIndexPath.section != destinationIndexPath.section) { //Assigning Tag Group ID by moving
                NSArray *arrayDestinationGroup = [[[arrayTagGroups objectAtIndex: destinationIndexPath.section] lastObject] objectForKey: @"group"];
                NSArray *arrayTag = [[arrayTagGroups objectAtIndex: sourceIndexPath.section] objectAtIndex: sourceIndexPath.row];
                [[arrayTag optionsDictionary] setObject: [[arrayDestinationGroup optionsDictionary] objectForKey: @"id"] forKey: @"groupID"];
                [[UniversalVariables globalVariables] TAGS_updateForTag: arrayTag];
                [self reloadTable];
                
            }
            break;
            
        } default:
            break;
            
    }
    
}

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
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [[UniversalVariables globalVariables] TAGS_deleteForTag: [[arrayTagGroups objectAtIndex: indexPath.section] objectAtIndex: indexPath.row]];
                [self reloadTable];
                
            }
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
                    array = [NSMutableArray arrayNEWStoryWithTitle: [[alertView textFieldAtIndex: 0] text] description: [[alertView textFieldAtIndex: 1] text]];
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
            if ([alertView tag] == 1) { //Adding Tag
                if (buttonIndex == 1) {
                    if ([alertView textFieldAtIndex: 0].text.length > 0) {
                        [[UniversalVariables globalVariables] TAGS_writeNewForTag: [NSMutableArray arrayNEWTagWithTitle: [[alertView textFieldAtIndex: 0] text]]];
                        [self reloadTable];
                        
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Tag" message: @"you cannot add a tag with no title value" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
                        [alert show];
                        
                    }
                    
                }
                
            } else if ([alertView tag] == 2) { //Modifying a Tag
                if (buttonIndex == 1) {
                    if ([alertView textFieldAtIndex: 0].text.length > 0) {
                        [array replaceObjectAtIndex: TAGS_title  withObject: [alertView textFieldAtIndex: 0].text];
                        [[UniversalVariables globalVariables] TAGS_updateForTag: array];
                        [self reloadTable];
                        
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Modifying a Tag" message: @"you cannot have a tag with no title value" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
                        [alert show];
                        
                    }
                    
                }
                
            } else if ([alertView tag] == 3) { //Long tap > Add
                if (buttonIndex == 1) {
                    if ([alertView textFieldAtIndex: 0].text.length > 0) {
                        [[UniversalVariables globalVariables] TAGGROUPS_writeNewForTagGroup: [NSArray arrayNEWTagGroupWithTitle: [alertView textFieldAtIndex: 0].text]];
                        [self reloadTable];
                        
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Tag Group" message: @"you cannot have a tag group with no title value" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
                        [alert show];
                        
                    }
                    
                }
                
            } else if ([alertView tag] == 4) { //Modifying a Tag Group
                if (buttonIndex == 1) {
                    if ([alertView textFieldAtIndex: 0].text.length > 0) {
                        [array replaceObjectAtIndex: TAGGROUPS_title  withObject: [alertView textFieldAtIndex: 0].text];
                        [[UniversalVariables globalVariables] TAGGROUPS_updateForTagGroup: array];
                        [self reloadTable];
                        
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Modifying a Tag" message: @"you cannot have a tag with no title value" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
                        [alert show];
                        
                    }
                    
                }
                
            } else if ([alertView tag] == -4) { //Deleting Tag Group Confirmation
                if (buttonIndex == 1) { //Delete
                    [[UniversalVariables globalVariables] TAGGROUPS_deleteForTagGroup: array];
                    [self reloadTable];
                    
                }
                
            }
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
            if ([actionSheet tag] == 1) { //Long tap > Add
                if (buttonIndex == 1) //Add Tag
                    [self pressedNavRight: [self.navigationItem rightBarButtonItem]];
                else if (buttonIndex == 0) { //Add Tag Group
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Tag Group" message: @"enter the title" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Add", nil];
                    [alert setTag: 3];
                    [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
                    [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
                    [[alert textFieldAtIndex: 0] setAutocorrectionType: UITextAutocorrectionTypeYes];
                    [[alert textFieldAtIndex: 0] setPlaceholder: @"title"];
                    [alert show];
                    
                }
                
            } else if ([actionSheet tag] == 2) { //Long tap > Modify Tag Group
                if (buttonIndex == 0) { //Rename
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Modify Tag Group" message: @"enter the title" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Save", nil];
                    [alert setTag: 4];
                    [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
                    [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
                    [[alert textFieldAtIndex: 0] setAutocorrectionType: UITextAutocorrectionTypeYes];
                    [[alert textFieldAtIndex: 0] setPlaceholder: @"title"];
                    [[alert textFieldAtIndex: 0] setText: [array objectTagGroup_title]];
                    [alert show];
                    
                } else if (buttonIndex == 1) { //Delete
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Modify Tag Group" message: [NSString stringWithFormat: @"are you sure you want to delete the tag group, %@? All tags in this group will be assigned to \"Ungroupped Tags\"", [array objectTagGroup_title]] delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Delete", nil];
                    [alert setTag: -4];
                    [alert show];
                    
                }
                
            }
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Tag" message: @"enter the title" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Add", nil];
            [alert setTag: 1];
            [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
            [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
            [[alert textFieldAtIndex: 0] setAutocorrectionType: UITextAutocorrectionTypeYes];
            [alert show];
            break;
            
        }
            
    }
    
}

- (void)pressedNavRightLong:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan)
        switch (currentView) {
            case CTMapView: {
                break;
                
            } case CTStoriesView: {
                break;
                
            } case CTTags: {
                UIActionSheet *actionAdd = [[UIActionSheet alloc] initWithTitle: nil delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: @"Add Tag Group", @"Add Tag", nil];
                [actionAdd setTag: 1];
                [actionAdd showInView: self.view];
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
            [tableTags setEditing: !tableTags.isEditing animated: YES];
            break;
            
        }
            
    }
    
}

- (void)pressedHeaderLong:(id)sender {
    if ([sender state] == UIGestureRecognizerStateBegan) {
        switch (currentView) {
            case CTMapView: {
                break;
                
            } case CTStoriesView: {
                break;
                
            } case CTTags: {
                if ([sender tag] != 0) {
                    array = [[[arrayTagGroups objectAtIndex: [sender tag]] lastObject] objectForKey: @"group"];
                    selectedIndexPath = [NSIndexPath indexPathForRow: 0 inSection: [sender tag]];
                    UIActionSheet *actionHeader = [[UIActionSheet alloc] initWithTitle: nil delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: @"Rename Tag Group", @"Delete Tag Group", nil];
                    [actionHeader setDestructiveButtonIndex: 1];
                    [actionHeader setTag: 2];
                    [actionHeader showInView: self.view];
                    
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Modifying Tag Groups" message: @"sorry, you cannont modify this tag group" delegate: nil cancelButtonTitle: @"Dismiss" otherButtonTitles: nil];
                    [alert show];
                    
                }
                break;
                
            }
                
        }
        
    }
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrayStories = [NSMutableArray new];
    arrayTagGroups = [NSMutableArray new];
    
    array = [NSMutableArray new];
    
    currentView = CTMapView;
    [viewStories setAlpha: 0];
    [viewStories setTransform: CGAffineTransformMakeScale( 0.85, 0.85)];
    [viewTags setAlpha: 0];
    [viewTags setTransform: CGAffineTransformMakeScale( 0.85, 0.85)];
    [viewMap.layer setShadowOpacity: 1];
    [viewMap.layer setShadowRadius: 12];
    [viewMap.layer setShadowColor: [[UIColor blackColor] CGColor]];
    
    [UniversalFunctions TAGGROUPS_returnGroupedTags];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
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
