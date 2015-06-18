//
//  DiaryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DiaryViewController.h"

@interface DiaryViewController () < UIAlertViewDelegate, UIActionSheetDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
        NSMutableArray *arrayDiaries;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"cell"];
    //Customize Cell
    [cell.textLabel setFont: [UIFont boldSystemFontOfSize: 12]];
    [cell.textLabel setText: [[arrayTable objectAtIndex: indexPath.row] objectEntry_subject]];
    [cell.detailTextLabel setText: [[arrayTable objectAtIndex: indexPath.row] objectEntry_body]];
    
    return cell;
    
}

#pragma mark - Void's

- (void)reloadTable {
    arrayTable = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLEntries]];
    arrayDiaries = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries]];
    [table reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark Void's > Pre-Defined Functions (ALERT VIEW)

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case 1: { //Add Diary
            if (buttonIndex == 1) { //Add
                NSMutableArray *arrayNewDiary = [NSMutableArray arrayNEWDiaryWithTitle: [alertView textFieldAtIndex: 0].text dateCreated: [NSDate date]];
                [[UniversalVariables globalVariables] DIARIES_writeNewForDiary: arrayNewDiary];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Diary" message: [NSString stringWithFormat: @"new diary, %@, was added!", [alertView textFieldAtIndex: 0].text] delegate: nil cancelButtonTitle: @"Dismiss" otherButtonTitles: nil];
                [alert show];
                [self reloadTable];
                
            }
            break;
            
        } case 2: { //Add Entry
            if (buttonIndex == 1) { //Next
                array = [NSMutableArray arrayNEWEntryWithSubject: [alertView textFieldAtIndex: 0].text body: [alertView textFieldAtIndex: 1].text];
                UIActionSheet *actionDiaries = [[UIActionSheet alloc] initWithTitle: @"New Entry" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: nil];
                [actionDiaries setTag: 1];
                for (NSArray *arrayDiary in arrayDiaries)
                    [actionDiaries addButtonWithTitle: [arrayDiary objectDiary_title]];
                [actionDiaries showInView: self.view];
                
            }
            break;
            
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
                [[array options] setValue: [[(NSArray *)[arrayDiaries objectAtIndex: buttonIndex] options] objectForKey: @"id"] forKey: @"diaryID"];
                [[UniversalVariables globalVariables] ENTRIES_writeNewForEntry: array];
                
            }
            break;
            
        }
            
        default:
            break;
    }
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Entry" message: @"enter the subject and body of this new entry" delegate: self cancelButtonTitle: @"Cancel" otherButtonTitles: @"Next", nil];
        [alert setTag: 2];
        [alert setAlertViewStyle: UIAlertViewStyleLoginAndPasswordInput];
        [[alert textFieldAtIndex: 0] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
        [[alert textFieldAtIndex: 1] setSecureTextEntry: NO];
        [[alert textFieldAtIndex: 1] setAutocapitalizationType: UITextAutocapitalizationTypeWords];
        [alert show];
        
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
    arrayTable = [NSMutableArray new];
    arrayDiaries = [NSMutableArray new];
    array = [NSMutableArray new];
    
}

- (void)viewWillAppear:(BOOL)animated {
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
