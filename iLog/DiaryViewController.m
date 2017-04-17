//
//  DiaryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DiaryViewController.h"

@interface DiaryViewController () < UIAlertViewDelegate, UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, DetailedEntryViewControllerDelegate, EntryViewConrollerDelegate, UIButtonsDelegate> {
    IBOutlet UITableView *table;
        NSFetchedResultsController *entriesController;
        NSIndexPath *indexpath;
    NSMutableArray *array;
}

@property (strong,nonatomic) NSArray<Diary *> *diaries;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

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
    _diaries = [Diary executeFetchRequest];
    
    return _diaries;
}

#pragma mark Return Functions > Pre-Defined Functions (TABLE VIEW)

//Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
    
}

//Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Title - Textview"];
    if (!cell)
        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTitleTextView];
    
    Entry *entry = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    [cell updateLayoutWithEntry: entry];
    
    return cell;
}

#pragma mark - Void's

- (void)statusBarTappedAction:(NSNotification *)notification {
    [self dismissViewControllerAnimated: YES completion: ^{}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [Entry fetchRequest];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"date" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    //gather current calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //gather date components from date
    NSDateComponents *date1Components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate: [NSDate date]];
    
    //set date components
    [date1Components setHour:0];
    [date1Components setMinute:0];
    [date1Components setSecond:0];
    
    //return date relative from date
    NSDate *startOfDay = [calendar dateFromComponents: date1Components];
    
    NSDateComponents *date2Components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate: [[NSDate date] dateByAddingTimeInterval: 60*60*24]];
    
    //set date components
    [date2Components setHour:0];
    [date2Components setMinute:0];
    [date2Components setSecond:0];
    
    NSDate *endOfDay = [calendar dateFromComponents: date2Components];
    
    [fetchRequest setPredicate: [NSPredicate predicateWithFormat: @"(date >= %@) AND (date < %@)", startOfDay, endOfDay]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[UniversalFunctions viewContext] sectionNameKeyPath:nil cacheName:@"today's entries"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
    
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
                
            }
            break;
            
        } default:
            break;
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ACTION SHEET)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch ([actionSheet tag]) {
            
        default:
            break;
    }
    
}

#pragma mark Void's > Pre-Defined Functions (TABLE VIEW)

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [table beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [table insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [table deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = table;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [(UICustomTableViewCell *)[tableView cellForRowAtIndexPath: indexPath] updateLayoutWithEntry: anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [table endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController: [[DetailedEntryViewController alloc] initWithEntry: [self.fetchedResultsController objectAtIndexPath: indexPath] delegate: self] animated: YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            [UniversalFunctions deleteObject: [self.fetchedResultsController objectAtIndexPath: indexPath]];
            break;
            
        } default:
            break;
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ENTRY VIEW CONTROLLER)

- (void)entryViewController:(EntryViewController *)entry didFinishWithEntry:(const NSArray *)array {
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Entry" message: @"there must be a Diary before adding an entry. Please add a Diary" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
        [alert show];
        
    }
    
}

- (void)buttonLongTap:(UIButtons *)button {
    if ([self.diaries count] > 0) {
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"New Entry" message: @"there must be a Diary before adding an entry. Please add a Diary" delegate: nil cancelButtonTitle: @"Okay" otherButtonTitles: nil];
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
    array = [NSMutableArray new];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
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
