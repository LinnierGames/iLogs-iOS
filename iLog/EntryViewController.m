//
//  EntryViewController.m
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "EntryViewController.h"
#import "DiaryController.h"

@interface EntryViewController () < UITableViewDataSource, UITableViewDelegate, UICustomTableViewCellDelegate, UITextFieldDelegate, UITextViewDelegate, UIContentPickerDelegate> {
    IBOutlet UITableView *table;
        NSMutableArray *arrayM;
        UICustomTableViewCell *cellSubject;
        UICustomTableViewCell *cellBody;
    
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

+ (UINavigationController *)modifyEntry:(const NSArray *)arrayEntry delegate:(id<EntryViewConrollerDelegate>)delegateValue {
    return [[UINavigationController alloc] initWithRootViewController: [[EntryViewController alloc] initWithCRUD: CTRead entry: arrayEntry delegate: delegateValue]];
    
}

- (id)initWithCRUD:(CRUD)value entry:(const NSArray *)arrayEntry delegate:(id< EntryViewConrollerDelegate>)delegateValue {
    self = [super initWithNibName: @"EntryViewController" bundle: [NSBundle mainBundle]];
    
    if (self) {
        arrayM = [[NSMutableArray alloc] initWithArray: arrayEntry];
        
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
            return 2; break;
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
                case 0:
                    return 34; break;
                case 1:
                    return 44; break;
                default:
                    return 44; break;
                    
            } break;
            
        } case 1: case 2:
            return 44; break;
        case 3:
            return 84; break;
        default:
            return 44; break;
            
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0: {
                    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Diary - Entry - Attributes"];
                    if (!cell)
                        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellDiaryEntryAttributes];
                    
                    switch ([arrayM objectEntry_emotion]) {
                        case CTEntryEmotionNoone:
                            [cell.button1 setImage: [UIImage imageNamed: @"misc_emotion-disabled"] forState: UIControlStateNormal];
                            break;
                        default:
                            [cell.button1 setImage: [UIImage imageNamed: @"misc_emotion-enabled"] forState: UIControlStateNormal];
                            break;
                            
                    }
                    switch ([arrayM objectEntry_weatherCondition]) {
                        case CTEntryWeatherConditionNoone:
                            [cell.button2 setImage: [UIImage imageNamed: @"misc_weather-disabled"] forState: UIControlStateNormal];
                            break;
                        default:
                            [cell.button2 setImage: [UIImage imageNamed: @"misc_weather-enabled"] forState: UIControlStateNormal];
                            break;
                            
                    }
                    if ([arrayM objectEntry_isBookmarked])
                        [cell.button3 setImage: [UIImage imageNamed: @"misc_bookmark-enabled"] forState: UIControlStateNormal];
                    else
                        [cell.button3 setImage: [UIImage imageNamed: @"misc_bookmark-disabled"] forState: UIControlStateNormal];
                    [cell setDelegate: self];
                    
                    return cell;
                    
                } case 1: {
                    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textfield"];
                    if (!cell)
                        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextField];
                    
                    [cell.textfield setDelegate: self];
                    [cell.textfield setTag: 1];
                    [cell.textfield setPlaceholder: @"Subject"];
                    [cell.textfield setText: [arrayM objectEntry_subject]];
                    
                    cellSubject = cell; return cell;
                    
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
                    [cell.textfield setPlaceholder: @"Stories"];
                    break;
                    
                } case 2: {
                    [cell.textfield setTag: 3];
                    [cell.textfield setPlaceholder: @"Tags"];
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
            
            cellBody = cell; return cell;
            break;
            
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

#pragma mark Void's > Pre-Defined Functions (SCROLL VIEW)

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self dismissFirstResponder];
    
}

#pragma mark Void's > Pre-Defined Functions (TEXT FIELD)

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual: cellSubject.textfield]) {
        [arrayM replaceObjectAtIndex: ENTRIES_subject withObject: textField.text];
        
    }
    
}

#pragma mark Void's > Pre-Defined Functions (TEXT VIEW)

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView isEqual: cellBody.textview]) {
        [arrayM replaceObjectAtIndex: ENTRIES_body withObject: textView.text];
        
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
            break;
            
        }
            
    }
    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 0 inSection: 0]] withRowAnimation: UITableViewRowAnimationNone];
    
}

#pragma mark Void's > Pre-Defined Functions (CONTENT PICKER)

- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithEntryEmotion:(CDEntryEmotions)selectedEmotion {
    [arrayM replaceObjectAtIndex: ENTRIES_emotion withObject: [NSNumber numberWithInt: selectedEmotion]];
    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 0 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
    
}

- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithEntryWeatherCondition:(CDEntryWeatherCondition)selectedWeatherCondition temperature:(CDEntryTemerature)selectedTemperature {
    [arrayM replaceObjectAtIndex: ENTRIES_weatherCondition withObject: [NSNumber numberWithInt: selectedWeatherCondition]];
    [arrayM replaceObjectAtIndex: ENTRIES_temperature withObject: [NSNumber numberWithInt: selectedTemperature]];
    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 0 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
    
}

#pragma mark - IBActions

- (void)pressNavLeft:(id)sender {
    [self dismissFirstResponder];
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
    
}

- (void)viewDidAppear:(BOOL)animated {
    [cellSubject.textfield becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

@end
