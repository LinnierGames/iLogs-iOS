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

#import "UIMarkdownInputView.h"

@interface EntryViewController () < UITableViewDataSource, UITableViewDelegate, UICustomTableViewCellDelegate, UITextFieldDelegate, UITextViewDelegate, UIContentPickerDelegate, UIActionSheetDelegate, UITableViewModuleViewController, UIMarkdownInputViewDelegate> {
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
    
    if (self) {
        arrayM = [[NSMutableArray alloc] initWithArray: arrayEntry];
        
        if ([[arrayM optionsDictionary] objectForKey: @"tagChanges"] == nil)
            [[arrayM optionsDictionary] setObject: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSMutableArray array], @"insert", [NSMutableArray array], @"delete", nil] forKey: @"tagChanges"];
        if ([[arrayM optionsDictionary] objectForKey: @"storyChanges"] == nil)
            [[arrayM optionsDictionary] setObject: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSMutableArray array], @"insert", [NSMutableArray array], @"delete", nil] forKey: @"storyChanges"];
        
        array = [NSMutableArray new];
        option = value;
        delegate = delegateValue;
        
    }
    
    return self;
    
}

#pragma mark Return Functions > Pre-Defined Functions (TABLE VIEW)

//Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
    
}

//Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 4; break;
        case 1:
            return 2; break;
        case 2:
            return 2; break;
        case 3:
            return 0; break;
        case 4:
            return 0; break;
        default:
            return 0; break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 2:
                    return 40; break;
                default:
                    return CVTableViewCellDefaultCellHeight; break;
                    
            } break;
            
        } case 1:
            return CVTableViewCellDefaultCellHeight; break;
        case 2: {
            switch (indexPath.row) {
                case 1:
                    return 96; break;
                default:
                    return CVTableViewCellDefaultCellHeight; break;
                    
            } break;
            
        } case 3:
            return 100; break;
        case 4:
            return 100; break;
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
                        [cell.button4 setBackgroundImage: [UIImage imageNamed: @"misc_bookmark-enabled"] forState: UIControlStateNormal];
                    else
                        [cell.button4 setBackgroundImage: [UIImage imageNamed: @"misc_bookmark-disabled"] forState: UIControlStateNormal];
                    [cell setDelegate: self];
                    
                    return cell; break;
                    
                } case 3: {
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
                    if (!cell)
                        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"cell"];
                    
                    [cell.textLabel setText: [[arrayM objectEntry_date] stringValue: CTCharacterDateTime]];
                    if ([[arrayM objectEntry_startDate] isEqualToDate: [NSDate dateWithTimeIntervalSince1970: 0]])
                        [cell.detailTextLabel setText: @""];
                    else
                        [cell.detailTextLabel setText: [[arrayM objectEntry_startDate] stringValue: CTCharacterDate]];
                    
                    return cell; break;
                    
                } default:
                    return nil; break;
                    
            } break;
            
        } case 1: {
            UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textfield"];
            if (!cell)
                cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextField];
            
            [cell.textfield setInputView: [UIView new]];
            [cell.textfield setDelegate: self];
            switch (indexPath.row) {
                case 0: {
                    [cell.textfield setTag: 2];
                    [cell.textfield setBorderStyle: UITextBorderStyleNone];
                    [cell.textfield setPlaceholder: @"Stories"];
                    cellStories = cell;
                    break;
                    
                } case 1: {
                    [cell.textfield setTag: 3];
                    [cell.textfield setBorderStyle: UITextBorderStyleNone];
                    [cell.textfield setPlaceholder: @"Tags"];
                    cellTags = cell;
                    break;
                    
                } default: break;
                    
            }
            
            return cell;
            
        } case 2: {
            switch (indexPath.row) {
                case 0: {
                    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Segment Buttons"];
                    if (!cell)
                        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellSegmentButtons];
                    
                    [cell.button1 setTitle: @"Body" forState: UIControlStateNormal];
                    [cell.button1 setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
                    [cell.button1 setBackgroundColor: [UIColor colorWithHexString: @"#037AFF" withAlpha: 1]];
                    [cell.button2 setTitle: @"Outline" forState: UIControlStateNormal];
                    [cell.button2 setTag: 1];
                    [cell setDelegate: self];
                    
                    return cell; break;
                    
                } case 1: {
                    UICustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Textview"];
                    if (!cell)
                        cell = [UICustomTableViewCell cellType: CTUICustomTableViewCellTextView];
                    
                    [cell.textview setText: [arrayM objectEntry_body]];
                    [cell.textview setUserInteractionEnabled: NO];
                    [cell setSelectionStyle: UITableViewCellSelectionStyleDefault];
                    [cell setAccessoryType: UITableViewCellAccessoryDisclosureIndicator];
                    
                    return cell; break;
                    
                } default:
                    return nil; break;
                    
            }
            break;
        
        } case 3: case 4: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
            if (!cell)
                cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: @"cell"];
            
            [cell.textLabel setText: @"Media"];
            
            return cell; break;
            
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
                case 1: { //Select Diary
                    UIAlertController *alertDiaries = [UIAlertController alertControllerWithTitle: @"" message: @"select a diary" preferredStyle: UIAlertControllerStyleActionSheet];
                    array = [NSMutableArray arrayWithArray: [UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries]];
                    for ( int buttonIndex = 0; buttonIndex < [array count]; buttonIndex += 1) {
                        NSArray *arrayDiary = [array objectAtIndex: buttonIndex];
                        [alertDiaries addAction: [UIAlertAction actionWithTitle: [arrayDiary objectDiary_title] style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            
                            if (![[[arrayM optionsDictionary] objectForKey: @"diary"] isEqualToArray: arrayDiary]) {
                                [[arrayM optionsDictionary] setValue: [array objectAtIndex: buttonIndex] forKey: @"diary"];
                                
                                while ([[[arrayM optionsDictionary] objectForKey: @"stories"] count] > 0) {
                                    NSNumber *numberStoryID = [[[[[arrayM optionsDictionary] objectForKey: @"stories"] firstObject] optionsDictionary] objectForKey: @"id"];
                                    if ([[[[arrayM optionsDictionary] objectForKey: @"storyChanges"] objectForKey: @"insert"] containsObject: numberStoryID])
                                        [[[[arrayM optionsDictionary] objectForKey: @"storyChanges"] objectForKey: @"insert"] removeObjectIdenticalTo: numberStoryID];
                                    else
                                        [[[[arrayM optionsDictionary] objectForKey: @"storyChanges"] objectForKey: @"delete"] addObject: numberStoryID];
                                    [[[arrayM optionsDictionary] objectForKey: @"stories"] removeObjectAtIndex: 0];
                                    
                                }
                                [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 1 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
                                
                            }
                            
                        }]];
                        
                    }
                    [alertDiaries addAction: [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleCancel handler: ^(UIAlertAction * _Nonnull action) { }]];
                    [self dismissFirstResponder];
                    [self presentViewController: alertDiaries animated: YES];
                    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 1 inSection: 0]] withRowAnimation: UITableViewRowAnimationFade];
                    
                    break;
                    
                } default:
                    break;
                    
            }
            break;
            
        } case 2: {
            if (indexPath.row == 1) {
                [self presentViewController: [UITableViewModuleViewController allocWithModule: CTTableViewBody withContent: [arrayM objectEntry_body]] animated: YES];
                
            } break;
            
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
    if ([cellStories.textfield isEqual: textField]) {
        UINavigationController *navStories = [UITableViewModuleViewController allocWithModule: CTTableViewStories withContent: @{@"stories": [[arrayM optionsDictionary] objectForKey: @"stories"], @"groupedStories": [UniversalFunctions STORIES_returnGroupedStories], @"entry": arrayM}];
        [(UITableViewModuleViewController *)navStories.topViewController setDelegate: self];
        [self presentViewController: navStories animated: YES completion: ^{ }];
        
    } else if ([cellTags.textfield isEqual: textField]) {
        UINavigationController *navTags = [UITableViewModuleViewController allocWithModule: CTTableViewTags withContent: @{@"tags": [[arrayM optionsDictionary] objectForKey: @"tags"], @"groupedTags": [UniversalFunctions TAGGROUPS_returnGroupedTags]}];
        [(UITableViewModuleViewController *)navTags.topViewController setDelegate: self];
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

#pragma mark Void's > Pre-Defined Functions (CUSTOM TABLE VIEW CELL)

- (void)customCell:(UICustomTableViewCell *)cell buttonPressed:(id)button {
    NSIndexPath *indexPath = [table indexPathForCell: cell];
    switch (indexPath.section) {
        case 0: {
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
                    
                } case 3: { //Highlight
                    break;
                    
                } case 4: { //Bookmark
                    [arrayM replaceObjectAtIndex: ENTRIES_isBookmarked withObject: [NSNumber numberWithBool: [arrayM objectEntry_isBookmarked] ? NO : YES]];
                    [table reloadRowsAtIndexPaths: @[[NSIndexPath indexPathForRow: 2 inSection: 0]] withRowAnimation: UITableViewRowAnimationNone];
                    break;
                    
                }
                    
            } break;
            
        } case 2: {
            if ([button tag] == 1) {
                NSLog( @"Outline");
                
            }
            break;
            
        } default:
            break;
            
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
    NSString *stringChangesHash = @"", *stringPluralHash = @"";
    CDSQLTables databaseTable;
    
    switch (tableViewModule.module) {
        case CTTableViewStories: {
            stringChangesHash = @"storyChanges";
            stringPluralHash = @"stories";
            databaseTable = CTSQLStories;
            
            break;
        } case CTTableViewTags: {
            stringChangesHash = @"tagChanges";
            stringPluralHash = @"tags";
            databaseTable = CTSQLTags;
            
            break;
            
        } default:
            stringChangesHash = @"tagChanges";
            stringPluralHash = @"tags";
            databaseTable = CTSQLTags;
            break;
            
    }
    
    //Add non duplicate object of id value to :_Changes:insert
    for (NSNumber *numberID in [dictionary objectForKey: @"insert"]) {
        if ([[[[arrayM optionsDictionary] objectForKey: stringChangesHash] objectForKey: @"delete"] containsObject: numberID]) { //Adding ID that is being removed
            [[[[arrayM optionsDictionary] objectForKey: stringChangesHash] objectForKey: @"delete"] removeObjectIdenticalTo: numberID];
            
        } else { //Add the ID to be added
            [[[[arrayM optionsDictionary] objectForKey: stringChangesHash] objectForKey: @"insert"] addObject: numberID];
            
        }
        
        //Add the tag to the :_ hash
        NSArray *arrayNew_ = [[UniversalFunctions SQL_returnContentOfTable: databaseTable withSuffix: [NSString stringWithFormat: @"WHERE id = %d", [numberID intValue]]] firstObject];
        [[[arrayM optionsDictionary] objectForKey: stringPluralHash] addObject: arrayNew_];
        
    }
    
    //Add non duplicate object of id value to :_Changes:delete
    for (NSNumber *numberID in [dictionary objectForKey: @"delete"]) {
        if ([[[[arrayM optionsDictionary] objectForKey: stringChangesHash] objectForKey: @"insert"] containsObject: numberID]) { //Removing ID that is being added
            [[[[arrayM optionsDictionary] objectForKey: stringChangesHash] objectForKey: @"insert"] removeObjectIdenticalTo: numberID];
            
        } else { //Add the ID to be removed
            [[[[arrayM optionsDictionary] objectForKey: stringChangesHash] objectForKey: @"delete"] addObject: numberID];
            
        }
        
        //Remove the ID from the :_ hash
        for (int index = 0; index < [[[arrayM optionsDictionary] objectForKey: stringPluralHash] count]; index += 1) {
            if ([[[[[[arrayM optionsDictionary] objectForKey: stringPluralHash] objectAtIndex: index] optionsDictionary] objectForKey: @"id"] isEqualToNumber: numberID]) {
                [[[arrayM optionsDictionary] objectForKey: stringPluralHash] removeObjectAtIndex: index];
                break;
                
            }
            
        }
        
    }
    
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
    [self.navigationItem setTitle: [[arrayM objectEntry_date] stringValue: CTCharacterDateTime]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (option == CTCreate)
        [cellSubject.textfield becomeFirstResponder];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
}

@end
