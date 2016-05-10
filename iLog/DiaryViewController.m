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

@interface DiaryViewController () < UIAlertViewDelegate, UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, DetailedEntryViewControllerDelegate, EntryViewConrollerDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
        NSMutableArray *arrayDiaries;
        NSIndexPath *indexpath;
    NSMutableArray *array;
}

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

#pragma mark Void's > Pre-Defined Functions (ENTRY VIEW CONTROLLER)

- (void)entryViewController:(EntryViewController *)entry didFinishWithEntry:(const NSArray *)array {
    [self reloadTable];
    
}

#pragma mark - IBActions

- (void)pressNavLeft:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Diary" message: @"enter the title of this new diary" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Add", nil];
    [alert setTag: 1];
    [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
    [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
    [alert show];
    
}

- (void)pressNavRight:(id)sender {
    if ([arrayDiaries count] > 0) {
        UINavigationController *viewNew = [EntryViewController newEntryWithDelegate: self];
        [self presentViewController: viewNew animated: YES];
        
        
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
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCompose target: self action: @selector( pressNavRight:)]];
    
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
