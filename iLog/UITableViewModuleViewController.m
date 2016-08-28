//
//  UITableViewModuleViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/25/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UITableViewModuleViewController.h"
#import "UIMarkdownInputView.h"

@interface UITableViewModuleViewController () < UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIMarkdownInputViewDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
        UICustomTableViewCell *cellSearch;
        UICustomTableViewCell *cellTextview;
    NSMutableDictionary *dicChanges;
    
    NSArray *arrayEntry;
    
}

@end

@interface UniversalFunctions (TableViewModule_)

/**
 * Used to insert a mutable dictionary, or adding to an exsisiting dictionary, with the following keys; highlighted:NO.
 * Used to display selected tags in a table view
 * @param [in, out] arrayTagGroups : +TAGGROUPS_retrunGroupedTagsWithTagGroups:
 */
+ (void)_voidUnhighlightTagsForFormattedTagGroups:(NSArray *)arrayTagGroups;

@end

@implementation UITableViewModuleViewController
@synthesize arrayM, stringM, module, delegate;

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

- (id)initWithModule:(CDTableViewModule)moduleValue {
    return [self initWithModule: moduleValue withContent:
            moduleValue == CTTableViewModule ? [NSArray array] :
            moduleValue == CTTableViewDiaries ? [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries] :
            moduleValue == CTTableViewTags ? @{@"groupedTags": [UniversalFunctions TAGGROUPS_returnGroupedTags]} : [NSArray array]];
    
}

- (id)initWithModule:(CDTableViewModule)moduleValue withContent:(id)content {
    self = [super initWithNibName: @"UITableViewModuleViewController" bundle: [NSBundle mainBundle]];
    if (self) {
        switch (moduleValue) {
            case CTTableViewTags: {
                arrayM = [[NSMutableArray alloc] initWithArray: [content objectForKey: @"groupedTags"]];
                [UniversalFunctions _voidUnhighlightTagsForFormattedTagGroups: arrayM];
                for (NSArray *arrayTag in [content objectForKey: @"tags"]) { //Highlight tags, content:tags, from the formatted arrayM
                    for (int groupIndex = 0; groupIndex < [arrayM count]; groupIndex += 1) {
                        for (int tagIndex = 0; tagIndex < [[arrayM objectAtIndex: groupIndex] count] -1; tagIndex += 1) {
                            if ([[[[[arrayM objectAtIndex: groupIndex] objectAtIndex: tagIndex] optionsDictionary] objectForKey: @"id"] isEqualToNumber: [[arrayTag optionsDictionary] objectForKey: @"id"]])
                                [[[[arrayM objectAtIndex: groupIndex] objectAtIndex: tagIndex] optionsDictionary] setValue: [NSNumber numberWithBool: YES] forKey: @"highlighted"];
                            
                            
                        }
                        
                    }
                    
                }
                arrayTable = [[NSMutableArray alloc] initWithArray: [UniversalFunctions TAGGROUPS_returnCopyOfTagsWithTagGroups: arrayM]];
                module = moduleValue;
                
                [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector( pressLeftNav:)]];
                [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector( pressRightNav:)]];
                break;
                
            } case CTTableViewStories: {
                arrayM = [[NSMutableArray alloc] initWithArray: [content objectForKey: @"groupedStories"]];
                [UniversalFunctions _voidUnhighlightTagsForFormattedTagGroups: arrayM];
                for (NSArray *arrayStory in [content objectForKey: @"stories"]) { //Highlight stories from arrayM from conent:groupedStories
                    for (int groupIndex = 0; groupIndex < [arrayM count]; groupIndex += 1) {
                        for (int storyIndex = 0; storyIndex < [[arrayM objectAtIndex: groupIndex] count] -1; storyIndex += 1) {
                            if ([[[[[arrayM objectAtIndex: groupIndex] objectAtIndex: storyIndex] optionsDictionary] objectForKey: @"id"] isEqualToNumber: [[arrayStory optionsDictionary] objectForKey: @"id"]])
                                [[[[arrayM objectAtIndex: groupIndex] objectAtIndex: storyIndex] optionsDictionary] setValue: [NSNumber numberWithBool: YES] forKey: @"highlighted"];
                            
                            
                        }
                        
                    }
                    
                }
                arrayTable = [[NSMutableArray alloc] initWithArray: [UniversalFunctions TAGGROUPS_returnCopyOfTagsWithTagGroups: arrayM]];
                module = moduleValue;
                
                arrayEntry = [content objectForKey: @"entry"];
                
                [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector( pressLeftNav:)]];
                [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector( pressRightNav:)]];
                break;
                
            } case CTTableViewDiaries: {
                arrayTable = [[NSMutableArray alloc] initWithArray: content];
                module = moduleValue;
                
                [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector( pressLeftNav:)]];
                [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemEdit target: self action: @selector( pressRightNav:)]];
                break;
                
            } case CTTableViewBody: {
                stringM = [NSMutableString stringWithString: content];
                module = moduleValue;
                
                [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel target: self action: @selector( pressLeftNav:)]];
                [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector( pressRightNav:)]];
                break;
                
            } default:
                break;
                
        }
        dicChanges = [[NSMutableDictionary alloc] initWithObjectsAndKeys: [NSMutableArray array], @"insert", [NSMutableArray array], @"delete", nil];
        
    }
    
    return self;
    
}

+ (UINavigationController *)allocWithModule:(CDTableViewModule)moduleValue {
    return [[UINavigationController alloc] initWithRootViewController: [[UITableViewModuleViewController alloc] initWithModule: moduleValue]];
    
}

+ (UINavigationController *)allocWithModule:(CDTableViewModule)moduleValue withContent:(id)content {
    return [[UINavigationController alloc] initWithRootViewController: [[UITableViewModuleViewController alloc] initWithModule: moduleValue withContent: content]];
    
}

#pragma mark Return Functions > Pre-Defined Functions (TABLE VIEW)

//Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (module) {
        case CTTableViewTags:
            return [arrayM count] +1; /*Search Bar on Top*/ break;
        case CTTableViewStories:
            return [arrayM count] +1; /*Search Bar on Top*/ break;
        case CTTableViewDiaries:
            return 2; /*Search Bar on Top*/ break;
        case CTTableViewBody:
            return 1; break;
        default:
            return 0; break;
            
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (module) {
        case CTTableViewTags: {
            if (section == 0)
                return @"";
            else
                return [[[[arrayM objectAtIndex: section -1] lastObject] objectForKey: @"group"] objectTagGroup_title];
            break;
            
        } case CTTableViewStories: {
            if (section == 0)
                return @"";
            else
                return [[[[arrayM objectAtIndex: section -1] lastObject] objectForKey: @"diary"] objectDiary_title];
            break;
            
        }
        default:
            return @""; break;
            
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (module) {
        default:
            return nil; break;
            
    }
    
}

//Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (module) {
        case CTTableViewTags: {
            if (section == 0)
                return 1;
            else
                return [[arrayTable objectAtIndex: section -1] count];
            break;
            
        } case CTTableViewStories: {
            if (section == 0)
                return 1;
            else
                return [[arrayTable objectAtIndex: section -1] count];
            break;
            
        } case CTTableViewDiaries: {
            if (section == 0)
                return 1;
            else
                return [arrayTable count] +1 /*Add Diary Button*/;
            break;
            
        } case CTTableViewBody:
            return 1; break;
        default:
            return 0; break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (module) {
        case CTTableViewBody:
            return 224; break;
        default:
            return CVTableViewCellDefaultCellHeight; break;
            
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (module) {
        case CTTableViewDiaries:
            if (indexPath.section != 0 && indexPath.row != 0)
                return YES;
            else
                return NO;
            break;
            
        default:
            return NO; break;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (module) {
        case CTTableViewBody: {
            UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textview"];
            if (!cell)
                cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextView];
            
            [cell.textview setDelegate: self];
            [cell.textview setTag: 1];
            [cell.textview setText: stringM];
            [cell.textview setInputAccessoryView: [[UIMarkdownInputView alloc] initWithTextInput: cell.textview withParentViewController: self]];
            
            cellTextview = cell; return cell; break;
            
            return nil;
            break;
            
        } default: {
            if (indexPath.section == 0) { //Search Bar
                UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Searchbar"];
                if (!cell)
                    cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellSearchBar];
                //Customize Cell
                [cell.searchBar setDelegate: self];
                
                cellSearch = cell; return cell;
                
            } else { //Record
                switch (module) {
                    case CTTableViewStories: case CTTableViewTags: {
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                        if (!cell)
                            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
                        //Customize Cell
                        
                        NSArray *arrayRecord = [[arrayTable objectAtIndex: indexPath.section -1] objectAtIndex: indexPath.row];
                        if ([[[arrayRecord optionsDictionary] objectForKey: @"highlighted"] boolValue])
                            [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
                        else
                            [cell setAccessoryType: UITableViewCellAccessoryNone];
                        
                        switch (module) {
                            case CTTableViewTags: {
                                [cell.textLabel setText: [arrayRecord objectTag_title]];
                                
                                break;
                                
                            } case CTTableViewStories: {
                                [cell.textLabel setText: [arrayRecord objectStory_title]];
                                if ([[[arrayRecord optionsDictionary] objectForKey: @"highlighted"] boolValue])
                                    [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
                                else
                                    [cell setAccessoryType: UITableViewCellAccessoryNone];
                                
                                if ([[[[[[arrayM objectAtIndex: indexPath.section -1] lastObject] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] isEqualToNumber: [[[[arrayEntry optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"]]) {
                                    [cell.textLabel setTextColor: [UIColor blackColor]];
                                    [cell setUserInteractionEnabled: YES];
                                    
                                } else {
                                    [cell.textLabel setTextColor: [UIColor lightGrayColor]];
                                    [cell setUserInteractionEnabled: NO];
                                    
                                }
                                
                                break;
                                
                            } default:
                                break;
                                
                        }
                        
                        return cell; break;
                        
                    } case CTTableViewDiaries: {
                        if (indexPath.row == 0) {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                            if (!cell)
                                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
                            //Customize Cell
                            
                            [cell.textLabel setText: @"Add Diary"];
                            
                            return cell;
                            
                        } else {
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                            if (!cell)
                                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
                            //Customize Cell
                            
                            NSArray *arrayRecord = [arrayTable objectAtIndex: indexPath.row -1];
                            [cell.textLabel setText: [arrayRecord objectDiary_title]];
                            
                            return cell;
                            
                        }
                        break;
                        
                    } default:
                        return nil; break;
                        
                }
                
            }
            break;
            
        }
            
    }
    
}

#pragma mark  Returning Values > Pre-Defined Functions ()

#pragma mark - Void's

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Void's > Pre-Defined Functions (TABLE VIEW)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (module) {
        case CTTableViewTags: case CTTableViewStories: {
            const NSArray *arrayRecord = [[arrayTable objectAtIndex: indexPath.section -1] objectAtIndex: indexPath.row];
            BOOL perviousState = [[[arrayRecord optionsDictionary] objectForKey: @"highlighted"] boolValue];
            [[arrayRecord optionsDictionary] setValue: [NSNumber numberWithBool: !perviousState] forKey: @"highlighted"];
            
            if (perviousState) { //Highlighted -> Unhighlighted
                NSNumber *numberId = [[arrayRecord optionsDictionary] objectForKey: @"id"];
                if ([[dicChanges objectForKey: @"insert"] containsObject: numberId])
                    [[dicChanges objectForKey: @"insert"] removeObjectIdenticalTo: numberId];
                else
                    [[dicChanges objectForKey: @"delete"] addObject: numberId];
                
            } else { //Unhighlighted -> Highlighted
                NSNumber *numberId = [[arrayRecord optionsDictionary] objectForKey: @"id"];
                if ([[dicChanges objectForKey: @"delete"] containsObject: numberId])
                    [[dicChanges objectForKey: @"delete"] removeObjectIdenticalTo: numberId];
                else
                    [[dicChanges objectForKey: @"insert"] addObject: numberId];
                
            }
            [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationFade];
            
            break;
            
        } case CTTableViewDiaries: {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"New Diary" message: @"enter the title of this new diary" preferredStyle: UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler: ^(UITextField * _Nonnull textField) {
                [textField setAutocapitalizationType: UITextAutocapitalizationTypeWords];
                [textField setAutocorrectionType: UITextAutocorrectionTypeYes];
                [textField setPlaceholder: @"title"];
                
            }];
            [alert addAction: [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler: NULL]];
            [alert addAction: [UIAlertAction actionWithTitle: @"Add" style: UIAlertActionStyleDefault handler: ^(UIAlertAction * _Nonnull action) {
                [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: [NSArray arrayNEWDiaryWithTitle: [[[alert textFields] firstObject] text]]];
                arrayTable = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries]];
                [tableView reloadData];
                
            }]];
            [self presentViewController: alert animated: YES completion: NULL];
            break;
        } default:
            break;
            
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (module) {
        case CTTableViewDiaries: {
            [UniversalFunctions SQL_DIARIES_voidDeleteRowWithArray: [arrayTable objectAtIndex: indexPath.row -1]];
            [arrayTable removeObjectAtIndex: indexPath.row -1];
            [tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
            break;
            
        } default:
            break;
    }
    
}

#pragma mark Void's > Pre-Defined Functions (SEARCH BAR)

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    switch (module) {
        case CTTableViewTags: {
            [searchBar setShowsCancelButton: YES animated: YES];
            break;
            
        }
        default:
            break;
            
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    switch (module) {
        case CTTableViewTags: {
            if (searchBar.text.length != 0) {
                [arrayTable removeAllObjects];
                for (int groupIndex = 0; groupIndex < [arrayM count]; groupIndex += 1) {
                    [arrayTable addObject: [NSMutableArray array]];
                    for (int tagIndex = 0; tagIndex < [[arrayM objectAtIndex: groupIndex] count] -1; tagIndex += 1) {
                        NSArray *arrayTag = [[arrayM objectAtIndex: groupIndex] objectAtIndex: tagIndex];
                        NSRange rangeString = [[arrayTag objectTag_title] rangeOfString: searchText options: NSCaseInsensitiveSearch];
                        if (rangeString.location != NSNotFound)
                            [[arrayTable objectAtIndex: groupIndex] addObject: arrayTag];
                        
                    }
                    
                }
                
            } else
                arrayTable = [NSMutableArray arrayWithArray: [UniversalFunctions TAGGROUPS_returnCopyOfTagsWithTagGroups: arrayM]];
            [table reloadData];
            break;
            
        }
        default:
            break;
            
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    switch (module) {
        default:
            break;
            
    }
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    switch (module) {
        case CTTableViewTags: {
            [searchBar setText: @""];
            [self searchBar: searchBar textDidChange: @""];
            [searchBar setShowsCancelButton: NO animated: YES];
            [searchBar resignFirstResponder];
            break;
            
        }
        default:
            break;
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (TEXT VIEW)

#pragma mark - IBActions

- (void)pressLeftNav:(id)sender {
    [self dismissViewControllerAnimated: YES completion: ^{ }];
    if ([cellTextview.textview isFirstResponder])
        [cellTextview.textview resignFirstResponder];
    
}

- (void)pressRightNav:(id)sender {
    switch (module) {
        case CTTableViewDiaries: {
            [table setEditing: !table.isEditing animated: YES];
            break;
            
        } case CTTableViewBody: {
            stringM = [NSMutableString stringWithString: cellTextview.textview.text];
            [dicChanges setValue: stringM forKey: @"body"];
        
        } default: {
            if ([delegate respondsToSelector: @selector( tableViewModule:didFinishWithChanges:)])
                [delegate tableViewModule: self didFinishWithChanges: dicChanges];
            //Dismiss
            [self pressLeftNav: nil];
            break;
            
        }
            
    }
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    switch (module) {
        case CTTableViewBody: {
            [cellTextview.textview becomeFirstResponder];
            break;
            
        } default:
            break;
            
    }
    
}

@end

@implementation UniversalFunctions (TableViewModule_)

+ (void)_voidUnhighlightTagsForFormattedTagGroups:(NSArray *)arrayTagGroups {
    for (int groupIndex = 0; groupIndex < [arrayTagGroups count]; groupIndex += 1) {
        for (int tagIndex = 0; tagIndex < [[arrayTagGroups objectAtIndex: groupIndex] count] -1 /*group hash*/; tagIndex += 1) {
            if ([[[[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: tagIndex] lastObject] isKindOfClass: [NSMutableDictionary class]])
                [[[[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: tagIndex] optionsDictionary] setValue: [NSNumber numberWithBool: NO] forKey: @"highlighted"];
            else
                 [[[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: tagIndex] addObject: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool: NO], @"highlighted", nil]];
            
        }
        
    }
    
}

@end
