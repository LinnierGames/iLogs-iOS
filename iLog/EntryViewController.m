//
//  EntryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "EntryViewController.h"
#import "UITableViewModuleViewController.h"
#import "DiaryController.h"

@interface EntryViewController () < UITableViewDataSource, UITableViewDelegate, UICustomTableViewCellDelegate, UITextFieldDelegate, UITextViewDelegate, UIContentPickerDelegate, UIActionSheetDelegate, UITableViewModuleViewController> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayM;
        UICustomTableViewCell *cellSubject;
        UICustomTableViewCell *cellBody;
        UICustomTableViewCell *cellStories;
        UICustomTableViewCell *cellTags;
    NSMutableArray *array;
    
}

@property ( assign) CRUD option;

@end

@implementation EntryViewController
@synthesize option, delegate;

#pragma mark - Return Functions

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        //Customize
        
    }
    
    return self;
    
}

+ (UINavigationController *)newEntryWithDelegate:(id<EntryViewConrollerDelegate>)delegateValue {
    return [[UINavigationController alloc] initWithRootViewController: [[EntryViewController alloc] initWithCRUD: CTCreate entry: [NSArray arrayNEWEntry] delegate: delegateValue]];
    
}

+ (UINavigationController *)modifyEntry:(NSArray *)arrayEntry delegate:(id<EntryViewConrollerDelegate>)delegateValue {
    return [[UINavigationController alloc] initWithRootViewController: [[EntryViewController alloc] initWithCRUD: CTRead entry: arrayEntry delegate: delegateValue]];
    
}

- (id)initWithCRUD:(CRUD)value entry:(NSArray *)arrayEntry delegate:(id< EntryViewConrollerDelegate>)delegateValue {
    self = [super initWithNibName: @"EntryViewController" bundle: [NSBundle mainBundle]];
    
    [UniversalFunctions SQL_ENTRIES_voidCreateTransactionRecord];
    
    if (self) {
        arrayM = [[NSMutableArray alloc] initWithArray: arrayEntry];
        array = [NSMutableArray new];
        
        if (value == CTCreate) {
            [[UniversalVariables globalVariables] ENTRIES_writeNewForEntry: arrayM];
            arrayM = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnRecordWithMaxIDOfTable: CTSQLEntries]];
            
            option = CTRead;
            
        }
        option = value;
        delegate = delegateValue;
        
    }
    
    return self;
    
}

#pragma mark Return Functions > Pre-Defined Functions (TABLE VIEW)

//Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
    
}

//Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3; break;
        case 1: case 2: case 3:
            return 1; break;
        default:
            return 0; break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0: case 1:
                    return CVTableViewCellDefaultCellHeight; break;
                case 2:
                    return 40; break;
                default:
                    return CVTableViewCellDefaultCellHeight; break;
                    
            } break;
            
        } case 1: case 2:
            return CVTableViewCellDefaultCellHeight; break;
        case 3:
            return 216; break;
        default:
            return CVTableViewCellDefaultCellHeight; break;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0: {
                    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textfield"];
                    if (!cell)
                        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextField];
                    
                    [cell.textfield setTag: 1];
                    [cell.textfield setBorderStyle: UITextBorderStyleNone];
                    [cell.textfield setClearButtonMode: UITextFieldViewModeWhileEditing];
                    [cell.textfield setPlaceholder: @"Subject"];
                    [cell.textfield setText: [arrayM objectEntry_subject]];
                    [cell.textfield setDelegate: self];
                    
                    cellSubject = cell; return cell; break;
                    
                } case 1: {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                    if (!cell)
                        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"cell"];
                    
                    [cell.textLabel setText: [[[arrayM optionsDictionary] objectForKey: @"diary"] objectDiary_title]];
                    
                    return cell; break;
                    
                } case 2: {
                    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Diary - Entry - Attributes"];
                    if (!cell)
                        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellDiaryEntryAttributes];
                    
                    [cell.imageview1 setImage: NSImageByEmotion( [arrayM objectEntry_emotion])];
                    switch ([arrayM objectEntry_emotion]) {
                        case CTEntryEmotionNoone: {
                            [cell.button1 setBackgroundImage: [UIImage imageNamed: @"misc_button-disabled"] forState: UIControlStateNormal];
                            [cell.button1 setTitle: @"empty" forState: UIControlStateNormal];
                            break;
                            
                        } default: {
                            [cell.button1 setBackgroundImage: [UIImage imageNamed: @"misc_emotionButton-enabled"] forState: UIControlStateNormal];
                            [cell.button1 setTitle: NSTitleByEmotion( [arrayM objectEntry_emotion]) forState: UIControlStateNormal];
                            break;
                            
                        }
                            
                    }
                    BOOL weather = [arrayM objectEntry_weatherCondition] != CTEntryWeatherConditionNoone, temperature = [arrayM objectEntry_temperature] != CTEntryTemperatureNoone;
                    if (weather) {
                        [cell.imageview2 setImage: NSImageByWeatherCondition( [arrayM objectEntry_weatherCondition])];
                        [cell.button2 setBackgroundImage: [UIImage imageNamed: @"misc_weatherButton-enabled"] forState: UIControlStateNormal];
                        [cell.button2 setTitle: NSTitleByWeatherCondition( [arrayM objectEntry_weatherCondition]) forState: UIControlStateNormal];
                        
                    } else if (temperature) {
                        [cell.imageview2 setImage: NSImageByTemperature( [arrayM objectEntry_temperature])];
                        [cell.button2 setBackgroundImage: [UIImage imageNamed: @"misc_weatherButton-enabled"] forState: UIControlStateNormal];
                        [cell.button2 setTitle: NSTitleByTemperature( [arrayM objectEntry_temperature]) forState: UIControlStateNormal];
                        
                    } else {
                        [cell.button2 setBackgroundImage: [UIImage imageNamed: @"misc_button-disabled"] forState: UIControlStateNormal];
                        [cell.imageview2 setImage: [UIImage imageNamed: @"misc_weather-disabled"]];
                        [cell.button2 setTitle: @"empty" forState: UIControlStateNormal];
                        
                    }
                    if ([arrayM objectEntry_isBookmarked])
                        [cell.button3 setBackgroundImage: [UIImage imageNamed: @"misc_bookmark-enabled"] forState: UIControlStateNormal];
                    else
                        [cell.button3 setBackgroundImage: [UIImage imageNamed: @"misc_bookmark-disabled"] forState: UIControlStateNormal];
                    [cell setDelegate: self];
                    
                    return cell; break;
                    
                } default:
                    return nil; break;
                    
            } break;
            
        } case 1: case 2: {
            UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textfield"];
            if (!cell)
                cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextField];
            
            [cell.textfield setDelegate: self];
            switch (indexPath.section) {
                case 1: {
                    [cell.textfield setTag: 2];
                    [cell.textfield setBorderStyle: UITextBorderStyleNone];
                    [cell.textfield setPlaceholder: @"Stories"];
                    cellStories = cell;
                    break;
                    
                } case 2: {
                    [cell.textfield setTag: 3];
                    [cell.textfield setBorderStyle: UITextBorderStyleNone];
                    [cell.textfield setPlaceholder: @"Tags"];
                    cellTags = cell;
                    break;
                    
                } default: break;
            }
            
            return cell;
            
        } case 3: {
            UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textview"];
            if (!cell)
                cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextView];
            
            [cell.textview setDelegate: self];
            [cell.textview setTag: 1];
            [cell.textview setText: [arrayM objectEntry_body]];
            
            cellBody = cell; return cell; break;
            
            /*
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
             if (!cell)
             cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"cell"];
             
             [cell.textLabel setText: @"Edit Body"];
             
             return cell; break;*/
            
        } default:
            return nil; break;
            
    }
    
}

#pragma mark Returning Functions > Pre-Defined Functions (TEXT FIELD)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark - Void's

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)dismissFirstResponder {
    if ([cellSubject.textfield isFirstResponder])
        [cellSubject.textfield resignFirstResponder];
    if ([cellBody.textview isFirstResponder])
        [cellBody.textview resignFirstResponder];
    
}

#pragma mark Void's > Pre-Defined Functions (TABLE VIEW) 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 1: {
                    UIActionSheet *actionDiaries = [[UIActionSheet alloc] initWithTitle: @"select a diary" delegate: self cancelButtonTitle: @"Cancel" destructiveButtonTitle: nil otherButtonTitles: nil];
                    [actionDiaries setTag: 1];
                    array = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries]];
                    for (NSArray *arrayDiary in array)
                        [actionDiaries addButtonWithTitle: [arrayDiary objectDiary_title]];
                    [self dismissFirstResponder];
                    [actionDiaries showInView: self.view];
                    break;
                    
                } default:
                    break;
                    
            }
            break;
            
        } case 3: {
//            [self.navigationController pushViewController: [[UITableViewModuleViewController alloc] initWithContent: [NSArray array]] animated: YES];
            break;
            
        } default:
            break;
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (SCROLL VIEW)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual: table])
        [self dismissFirstResponder];
    
}

#pragma mark Void's > Pre-Defined Functions (TEXT FIELD)

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([cellTags.textfield isEqual: textField]) {
        UINavigationController *navTags = [UITableViewModuleViewController allocWithModule: CTTableViewTags withContent: @{@"tags":[[arrayM optionsDictionary] objectForKey: @"tags"], @"groupedTags":[UniversalFunctions TAGGROUPS_returnGroupedTags]}];
        [self presentViewController: navTags animated: YES completion: ^{ }];
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual: cellSubject.textfield]) {
        [arrayM replaceObjectAtIndex: ENTRIES_subject withObject: textField.text];
        
    }
    
}

#pragma mark Void's > Pre-Defined Functions (TEXT VIEW)

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [table setContentOffset: CGPointMake( 0, 124) animated: YES];
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView isEqual: cellBody.textview]) {
        [arrayM replaceObjectAtIndex: ENTRIES_body withObject: textView.text];
        
    }
    
}

#pragma mark Void's > Pre-Defined Functions (ACTION SHEET)

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch ([actionSheet tag]) {
        case 1: { //Select Diary
            if (buttonIndex != 0) {
                [[arrayM optionsDictionary] setValue: [array objectAtIndex: buttonIndex -1] forKey: @"diary"];
                [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 1 inSection: 0]] withRowAnimation: UITableViewRowAnimationNone];
                
            }
            break;
            
        } default:
            break;
    }
    
}

#pragma mark Void's > Pre-Defined Functions (CUSTOM TABLE VIEW CELL)

- (void)customCell:(UICustomTableViewCell *)cell buttonPressed:(id)button {
    switch ([button tag]) {
        case 1: { //Emotions
            UIContentPicker *pickerEmotion = [[UIContentPicker alloc] initWithSelectedEmotion: [arrayM objectEntry_emotion] delegate: self];
            [self dismissFirstResponder];
            [pickerEmotion showAnimated: YES];
            break;
            
        } case 2: { //Weather
            UIContentPicker *pickerWeatherCondition = [[UIContentPicker alloc] initWithSelectedWeatherCondition: [arrayM objectEntry_weatherCondition] temperature: [arrayM objectEntry_temperature] delegate: self];
            [self dismissFirstResponder];
            [pickerWeatherCondition showAnimated: YES];
            break;
            
        } case 3: { //Bookmark
            [arrayM replaceObjectAtIndex: ENTRIES_isBookmarked withObject: [NSNumber numberWithBool: [arrayM objectEntry_isBookmarked] ? NO : YES]];
            [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 2 inSection: 0]] withRowAnimation: UITableViewRowAnimationNone];
            break;
            
        }
            
    }
    
}

#pragma mark Void's > Pre-Defined Functions (CONTENT PICKER)

- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithEntryEmotion:(CDEntryEmotions)selectedEmotion {
    [arrayM replaceObjectAtIndex: ENTRIES_emotion withObject: [NSNumber numberWithInt: selectedEmotion]];
    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 2 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
    
}

- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithEntryWeatherCondition:(CDEntryWeatherCondition)selectedWeatherCondition temperature:(CDEntryTemerature)selectedTemperature {
    [arrayM replaceObjectAtIndex: ENTRIES_weatherCondition withObject: [NSNumber numberWithInt: selectedWeatherCondition]];
    [arrayM replaceObjectAtIndex: ENTRIES_temperature withObject: [NSNumber numberWithInt: selectedTemperature]];
    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 2 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
    
}

#pragma mark Void's > Pre-Defined Functions (TABLE VIEW MODULE)

- (void)tableViewModule:(UITableViewModuleViewController *)tableViewModule didFinishWithChanges:(NSDictionary *)dictionary {
    switch (tableViewModule.module) {
        case CTTableViewTags: {
            //Add Records to TagEntriesRelationship Table
            for (NSArray *arrayChange in [dictionary objectForKey: @"insert"]) {
                NSNumber *numberTagID = [arrayChange firstObject];
                NSArray *arrayRelationship = [NSArray arrayNEWTagEntriesRelationshipWithTagID: numberTagID entryID: [[arrayM optionsDictionary] objectForKey: @"id"]];
                [[UniversalVariables globalVariables] TAGENTRIES_writeNewForTagEntryRelationship: arrayRelationship];
                [[[arrayM optionsDictionary] objectForKey: @"tags"] addObject: arrayRelationship];
                
            }
            //Remove Recoreds from TagEntriesRelationship Table
            for (NSArray *arrayChange in [dictionary objectForKey: @"delete"]) {
                NSNumber *numberTagID = [arrayChange firstObject];
                NSArray *arrayRelationship = [NSArray arrayNEWTagEntriesRelationshipWithTagID: numberTagID entryID: [[arrayM optionsDictionary] objectForKey: @"id"]];
                [[UniversalVariables globalVariables] TAGENTRIES_deleteForTagEntryRelationship: arrayRelationship];
                [[[arrayM optionsDictionary] objectForKey: @"tags"] removeObjectIdenticalTo: arrayRelationship];
                
                
            }
            break;
            
        }
            
        default:
            break;
    }
    
}

#pragma mark - IBActions

- (void)pressNavLeft:(id)sender {
    [self dismissFirstResponder];
    
    [UniversalFunctions SQL_ENTRIES_voidRollbackTransaction];
    
    [self dismissViewControllerAnimated: YES completion: ^{ }];
    
}

- (void)pressNavRight:(id)sender {
    [self dismissFirstResponder];
    switch (option) {
        case CTCreate: {
            [[UniversalVariables globalVariables] ENTRIES_writeNewForEntry: arrayM];
            break;
            
        } case CTRead: {
            [[UniversalVariables globalVariables] ENTRIES_updateForEntry: arrayM];
            break;
            
        }
            
    }
    
    [UniversalFunctions SQL_ENTRIES_voidCommitTransaction];
    
    [self dismissViewControllerAnimated: YES completion: ^{ }];
    if ([delegate respondsToSelector: @selector( entryViewController:didFinishWithEntry:)])
        [delegate entryViewController: self didFinishWithEntry: arrayM];
    
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setLeftBarButtonItem: [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStylePlain target: self action: @selector( pressNavLeft:)]];
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithTitle: @"Save" style: UIBarButtonItemStyleDone target: self action: @selector( pressNavRight:)]];
    [self.navigationItem setTitle: [[arrayM objectEntry_date] stringValue: CTCharacterDateTime]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    if (option == CTCreate)
        [cellSubject.textfield becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

@end
