//
//  UITableViewModuleViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/25/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UITableViewModuleViewController.h"

@interface UITableViewModuleViewController () < UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
        UICustomTableViewCell *cellSearch;
    NSMutableDictionary *dicChanges;
    
}

@end

@interface UniversalFunctions (TableViewModule_)

/**
 * Used to insert a mutable dictionary, or adding to an exsisiting dictionary, with the following keys; highlighted:NO.
 * Used to display selected tags in a table view
 * @param [in, out] arrayTagGroups : +TAGGROUPS_retrunGroupedTagsWithTagGroups:
 */
+ (void)TAGGROUPS_voidUnhighlightTagsForFormattedTagGroups:(NSArray *)arrayTagGroups;

/**
 * This will remove changes made like add one, but then remove the same object. this change "cancels" each other out
 * therefore it's not needed
 * @param [in,out] dictionary : in the format created for TAAGROUPS
 */
+ (void)TAGGROUPS_voidRemoveDuplicateChangesForDictionary:(NSMutableDictionary *)dictionary;

@end

@implementation UITableViewModuleViewController
@synthesize arrayM, module, delegate;

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

- (id)initWithModule:(CDTableViewModule)moduleValue {
    return [self initWithModule: moduleValue withContent: moduleValue == CTTableViewModule ? [NSArray array] : moduleValue == CTTableViewDiaries ? [NSArray array] : moduleValue == CTTableViewTags ? @{@"groupedTags":[UniversalFunctions TAGGROUPS_returnGroupedTags]} : [NSArray array]];
    
}

- (id)initWithModule:(CDTableViewModule)moduleValue withContent:(id)content {
    self = [super initWithNibName: @"UITableViewModuleViewController" bundle: [NSBundle mainBundle]];
    if (self) {
        switch (moduleValue) {
            case CTTableViewTags: {
                arrayM = [[NSMutableArray alloc] initWithArray: [content objectForKey: @"groupedTags"]];
                [UniversalFunctions TAGGROUPS_voidUnhighlightTagsForFormattedTagGroups: arrayM];
                for (NSArray *arrayTag in [content objectForKey: @"tags"]) { //Highlight tags from arrayM from conent:groupedTags
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
            
        }
        default:
            return 0; break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CVTableViewCellDefaultCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (module) {
        case CTTableViewTags: {
            if (indexPath.section == 0) { //Search Bar
                UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Searchbar"];
                if (!cell)
                    cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellSearchBar];
                //Customize Cell
                [cell.searchBar setDelegate: self];
                
                cellSearch = cell; return cell;
            
            } else { //Tag
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                if (!cell)
                    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
                //Customize Cell
                NSArray *arrayTag = [[arrayTable objectAtIndex: indexPath.section -1] objectAtIndex: indexPath.row];
                
                [cell.textLabel setText: [arrayTag objectTag_title]];
                if ([[[arrayTag optionsDictionary] objectForKey: @"highlighted"] boolValue])
                    [cell setAccessoryType: UITableViewCellAccessoryCheckmark];
                else
                    [cell setAccessoryType: UITableViewCellAccessoryNone];
                
                return cell;
                
            } break;
            
        } default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
            //Customize Cell
            
            return cell; break;
            
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
        case CTTableViewTags: {
            const NSArray *arrayTag = [[arrayTable objectAtIndex: indexPath.section -1] objectAtIndex: indexPath.row];
            BOOL perviousState = [[[arrayTag optionsDictionary] objectForKey: @"highlighted"] boolValue];
            //NSNumber *idIndex = [[arrayTag optionsDictionary] objectForKey: @"id"];
            [[arrayTag optionsDictionary] setValue: [NSNumber numberWithBool: !perviousState] forKey: @"highlighted"];
        /*  for (int groupIndex = 0; groupIndex < [arrayM count]; groupIndex += 1) { //Apply Changes to arrayM by searching for the matching idIndex from arrayTable
                for (int tagIndex = 0; tagIndex < [[arrayM objectAtIndex: groupIndex] count] -1; tagIndex += 1) {
                    if ([[[[[arrayM objectAtIndex: groupIndex] objectAtIndex: tagIndex] optionsDictionary] objectForKey: @"id"] isEqualToNumber: idIndex])
                        [[[[arrayM objectAtIndex: groupIndex] objectAtIndex: tagIndex] optionsDictionary] setValue: [[arrayTag optionsDictionary] objectForKey: @"highlighted"] forKey: @"highlighted"];

                    
                }
                
            }* Unessary due to arrays pointing to the same address */
            [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationNone];
            if (perviousState) { //Highlighted -> Unghighlighted
                [[dicChanges objectForKey: @"delete"] addObject: [NSArray arrayWithObjects: [[[[arrayTable objectAtIndex: indexPath.section] objectAtIndex: indexPath.row] optionsDictionary] objectForKey: @"id"], nil]];
                
            } else {
                [[dicChanges objectForKey: @"insert"] addObject: [NSArray arrayWithObjects: [[[[arrayTable objectAtIndex: indexPath.section] objectAtIndex: indexPath.row] optionsDictionary] objectForKey: @"id"], nil]];
                
            }
            
            break;
            
        }
        default:
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

#pragma mark - IBActions

- (void)pressLeftNav:(id)sender {
    [self dismissViewControllerAnimated: YES completion: ^{ }];
    
}

- (void)pressRightNav:(id)sender {
    [UniversalFunctions TAGGROUPS_voidRemoveDuplicateChangesForDictionary: dicChanges];
    if ([delegate respondsToSelector: @selector( tableViewModule:didFinishWithChanges:)])
         [delegate tableViewModule: self didFinishWithChanges: dicChanges];
    //Dismiss
    [self pressLeftNav: nil];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end

@implementation UniversalFunctions (TableViewModule_)

+ (void)TAGGROUPS_voidUnhighlightTagsForFormattedTagGroups:(NSArray *)arrayTagGroups {
    for (int groupIndex = 0; groupIndex < [arrayTagGroups count]; groupIndex += 1) {
        for (int tagIndex = 0; tagIndex < [[arrayTagGroups objectAtIndex: groupIndex] count] -1 /*group hash*/; tagIndex += 1) {
            if ([[[[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: tagIndex] lastObject] isKindOfClass: [NSMutableDictionary class]])
                [[[[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: tagIndex] optionsDictionary] setValue: [NSNumber numberWithBool: NO] forKey: @"highlighted"];
            else
                 [[[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: tagIndex] addObject: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool: NO], @"highlighted", nil]];
            
        }
        
    }
    
}

+ (void)TAGGROUPS_voidRemoveDuplicateChangesForDictionary:(NSMutableDictionary *)dictionary {
    NSUInteger index = 0;
    while (index < [[dictionary objectForKey: @"insert"] count]) {
        BOOL isFound = false;
        NSUInteger subindex = 0;
        while (subindex < [[dictionary objectForKey: @"delete"] count]) {
            if ([[[dictionary objectForKey: @"insert"] objectAtIndex: index] isEqualToArray: [[dictionary objectForKey: @"delete"] objectAtIndex: subindex]]) {
                [[dictionary objectForKey: @"insert"] removeObjectAtIndex: index];
                [[dictionary objectForKey: @"delete"] removeObjectAtIndex: subindex];
                isFound = true;
                break;
                
            }
            
        }
        if (!isFound)
            index += 1;
        
    }
    
}

@end
