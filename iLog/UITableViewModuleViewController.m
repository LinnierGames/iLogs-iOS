//
//  UITableViewModuleViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/25/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UITableViewModuleViewController.h"

@interface UITableViewModuleViewController () < UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
    
}

@end

@implementation UITableViewModuleViewController
@synthesize arrayM, module;

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

- (id)initWithContent:(id)value {
    self = [super initWithNibName: @"UITableViewModuleViewController" bundle: [NSBundle mainBundle]];
    if (self) {
        arrayTable = [NSMutableArray new];
        
    }
    
    return self;
    
}

- (id)initWithModule:(CDTableViewModule)moduleValue {
    return [self initWithModule: moduleValue withContent: moduleValue == CTTableViewModule ? [NSArray array] : moduleValue == CTTableViewDiaries ? [NSArray array] : moduleValue == CTTableViewTags ? [UniversalFunctions TAGGROUPS_returnGroupedTags] : [NSArray array]];
    
}

- (id)initWithModule:(CDTableViewModule)moduleValue withContent:(NSArray *)arrayValue {
    self = [self initWithContent: nil];
    if (self) {
        arrayM = [[NSMutableArray alloc] initWithArray: arrayValue];
        arrayTable = [[NSMutableArray alloc] initWithArray: [UniversalFunctions TAGGROUPS_returnCopyOfTagsWithTagGroups: arrayM]];
        module = moduleValue;
        
    }
    
    return self;
    
}

+ (UINavigationController *)allocWithModule:(CDTableViewModule)moduleValue {
    return [[UINavigationController alloc] initWithRootViewController: [[UITableViewModuleViewController alloc] initWithModule: moduleValue]];
    
}

+ (UINavigationController *)allocWithModule:(CDTableViewModule)moduleValue withContent:(NSArray *)arrayContent {
    return [[UINavigationController alloc] initWithRootViewController: [[UITableViewModuleViewController alloc] initWithModule: moduleValue withContent: arrayContent]];
    
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
            if (indexPath.section == 0) {
                UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Searchbar"];
                if (!cell)
                    cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellSearchBar];
                //Customize Cell
                [cell.searchBar setDelegate: self];
                
                return cell;
            
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                if (!cell)
                    cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
                //Customize Cell
                NSArray *arrayTag = [[arrayTable objectAtIndex: indexPath.section -1] objectAtIndex: indexPath.row];
                
                [cell.textLabel setText: [arrayTag objectTag_title]];
                
                return cell;
                
            } break;
            
        }
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
            //Customize Cell
            
            return cell; break;
            
        }
            
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
            [searchBar setShowsCancelButton: NO animated: YES];
            [searchBar resignFirstResponder];
            break;
            
        }
        default:
            break;
            
    }
    
}

#pragma mark - Void's

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
