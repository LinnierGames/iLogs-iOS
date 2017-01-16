//
//  DiaryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DiaryViewController.h"

#import <markdown_peg.h>
#import <markdown_lib.h> 

@interface DiaryViewController () < UIAlertViewDelegate, UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, DetailedEntryViewControllerDelegate, EntryViewConrollerDelegate, UIButtonsDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
        NSMutableArray *arrayDiaries;
        NSIndexPath *indexpath;
    NSMutableArray *array;
}

@property (strong,nonatomic) NSArray<Diary *> *diaries;

@end

@implementation DiaryViewController

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

- (NSArray<Diary *> *)diaries {
    //!if (_diaries == nil) core data refreshes itself? to stay updated on the result from any changes to diaries
    _diaries = [Diary executeFetchRequest];
    
    return _diaries;
}

#pragma mark Return Functions > Pre-Defined Functions (TABLE VIEW)

//Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

//Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayTable count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Title - Textview"];
    if (!cell)
        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTitleTextView];
    
    [cell.labelTitle setUserInteractionEnabled: NO];
    [cell.labelTitle setText: [[arrayTable objectAtIndex: indexPath.row] objectEntry_subject]];
    [cell.labelSubtitle setUserInteractionEnabled: NO];
    [cell.labelSubtitle setText: [[arrayTable objectAtIndex: indexPath.row] objectEntry_body]];
    
    cell.labelSubtitle.attributedText = markdown_to_attr_string(cell.labelSubtitle.text, 0, [[UniversalVariables globalVariables] attributedMarkdown]);
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraints];
    
    [cell setBackgroundColor: [[[arrayTable objectAtIndex: indexPath.row] objectEntry_date] dayNightColorByTimeOfDay]];
    
    return cell;
}

#pragma mark - Void's

- (void)reloadTable {
    #warning remove update to table with arrays
    arrayTable = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLEntries]];
    arrayDiaries = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries]];
    [table reloadData];
    
}

- (void)statusBarTappedAction:(NSNotification *)notification {
    [self dismissViewControllerAnimated: YES completion: ^{}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark Void's > Pre-Defined Functions (ALERT VIEW)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 1: { //Add Diary
            if ([[alertView textFieldAtIndex: 0] isFirstResponder])
                [[alertView textFieldAtIndex: 0] resignFirstResponder];
            if (buttonIndex == 1) { //Add
                NSMutableArray *arrayNewDiary = [NSMutableArray arrayNEWDiaryWithTitle: [alertView textFieldAtIndex: 0].text];
                [[UniversalVariables globalVariables] DIARIES_writeNewForDiary: arrayNewDiary];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Diary" message: [NSString stringWithFormat: @"new diary, %@, was added!", [alertView textFieldAtIndex: 0].text] delegate: nil cancelButtonTitle: @"Dismiss" otherButtonTitles: nil];
                [alert show];
                [self reloadTable];
                
            }
            break;
            
        } case 2: { //View Entry > Edit Entry
            if (buttonIndex == 1) {
                UINavigationController *viewEdit = [EntryViewController modifyEntry: [arrayTable objectAtIndex: indexpath.row] delegate: self];
                [self presentViewController: viewEdit animated: YES completion: ^{ }];
                
            }
            
        }
            
        default:
            break;
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ACTION SHEET)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch ([actionSheet tag]) {
        case 1: { //Add Entry > Select Diary
            if (buttonIndex != 0) {
                buttonIndex -= 1;
                [[array optionsDictionary] setValue: [[(NSArray *)[arrayDiaries objectAtIndex: buttonIndex] optionsDictionary] objectForKey: @"id"] forKey: @"diaryID"];
                [[UniversalVariables globalVariables] ENTRIES_writeNewForEntry: array];
                [self reloadTable];
                
            }
            break;
            
        }
            
        default:
            break;
    }
    
}

#pragma mark Void's > Pre-Defined Functions (TABLE VIEW)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController: [[DetailedEntryViewController alloc] initWithEntry: [arrayTable objectAtIndex: indexPath.row] delegate: self] animated: YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            [[UniversalVariables globalVariables] ENTRIES_deleteForEntry: [arrayTable objectAtIndex: indexPath.row]];
            [arrayTable removeObjectAtIndex: indexPath.row];
            [tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
            break;
            
        } default:
            break;
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ENTRY VIEW CONTROLLER)

- (void)entryViewController:(EntryViewController *)entry didFinishWithEntry:(const NSArray *)array {
    [self reloadTable];
    
}

#pragma mark - IBActions

- (void)pressNavLeft:(id)sender {
    #warning temporary add a diary
    Diary *newDiary = [Diary diary];
    [UniversalFunctions saveContext];
    return;
    [self presentViewController: [UITableViewModuleViewController allocWithModule: CTTableViewDiaries] animated: YES];
    
}

#pragma mark IBActions > Pre-Defined Functions (BUTTONS)

- (void)buttonTapped:(UIButtons *)button {
    if ([self.diaries count] > 0) {
        UINavigationController *viewNew = [EntryViewController newEntryWithDelegate: self];
        [self presentViewController: viewNew animated: YES];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Diary" message: @"there must be a Diary before adding an entry. Please add a Diary" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
        [alert show];
        
    }
    
}

- (void)buttonLongTap:(UIButtons *)button {
    
    [self.navigationController pushViewController: [[DetailedEntryViewController alloc] initWithEntry: [[[self.diaries firstObject] entries] anyObject] delegate: self] animated: YES];
    
    return;
    if ([arrayDiaries count] > 0) {
        [[UniversalVariables globalVariables] ENTRIES_writeNewForEntry: [NSMutableArray arrayNEWEntryWithSubject: @"New Entry" body: @"asdl;fkasdflk;jadsf ajsdf asfjkasf askfj asdf asdf jafsdkj fsadkf asdf asdflkjasd faskdf af jasfl;kj afdlkasj flk;asf jasklf; jaskfl ;jasfk ljasdflkjsfdlkjasfkl;jasfdkl; jiowe owenovnjvxcm,noweinovdn vn o noavni cvoxicvhadoi doas sn"]];
        [self viewWillAppear: NO];
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Diary" message: @"there must be a Diary before adding an entry. Please add a Diary" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
        [alert show];
        
    }
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action: @selector( pressNavLeft:)]];
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithCustomView: [UIButtons buttonWithType: CTButtonsCompose withDelegate: self]]];
    //[self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCompose target: self action: @selector( pressNavRight:)]];
    
    [table setRowHeight: UITableViewAutomaticDimension];
    [table setEstimatedRowHeight: 44.0];
    
    arrayTable = [NSMutableArray new];
    arrayDiaries = [NSMutableArray new];
    array = [NSMutableArray new];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [[UniversalVariables globalVariables] setViewController: self asCurrentView: self];
    [self reloadTable];
    
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
