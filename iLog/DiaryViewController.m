//
//  DiaryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DiaryViewController.h"

@interface DiaryViewController () < UIAlertViewDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayTable;
    
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
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"cell"];
    //Customize Cell
    [cell.textLabel setText: [[arrayTable objectAtIndex: indexPath.row] objectDiary_title]];
    
    return cell;
    
}

#pragma mark - Void's

- (void)reloadTable {
    arrayTable = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries]];
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
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd target: self action: @selector( pressNavLeft:)]];
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCompose target: self action: @selector( pressNavRight:)]];
    arrayTable = [NSMutableArray new];
    
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
