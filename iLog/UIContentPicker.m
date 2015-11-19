//
//  UIContentPicker.m
//  iLog
//
//  Created by Erick Sanchez on 6/22/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UIContentPicker.h"

static NSUInteger DIARY_ENTRY_weatherCondition = 0;
static NSUInteger DIARY_ENTRY_temperature = 1;

@interface UIContentPicker () < UIPickerViewDataSource, UIPickerViewDelegate> {
    IBOutlet UIView *contentView;
    IBOutlet UIPickerView *picker;
    IBOutlet UISegmentedControl *segTheme;
    IBOutlet UIButton *button;
    
    const NSArray *array;
    
}

@end

@implementation UIContentPicker
@synthesize delegate, contentPicker, isShowing;

#pragma mark - Return Functions

- (id)initWithSelectedColor:(CDColorTraits)colorValue delegate:(id< UIContentPickerDelegate>)delegateValue {
    self = [[[NSBundle mainBundle] loadNibNamed: @"UIContentPicker" owner: self options: NULL] objectAtIndex: CTContentColorPicker];
    [self setFrame: CGRectCurrentDevice()];
    contentPicker = CTContentColorPicker;
    delegate = delegateValue;
    array = [[NSArray alloc] initWithArray: NSColorArrayByTheme()];
    NSInteger theme, row;
    [self statusOfColor: colorValue withSeg: &theme withRow: &row];
    [segTheme setSelectedSegmentIndex: theme];
    [picker selectRow: row inComponent: 0 animated: NO];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
    return self;
    
}

- (id)initWithSelectedEmotion:(CDEntryEmotions)emotionValue delegate:(id< UIContentPickerDelegate>)delegateValue {
    self = [[[NSBundle mainBundle] loadNibNamed: @"UIContentPicker" owner: self options: NULL] objectAtIndex: CTContentEmotionPicker];
    [self setFrame: CGRectCurrentDevice()];
    contentPicker = CTContentEmotionPicker;
    delegate = delegateValue;
    array = [[NSArray alloc] initWithArray: NSEmotionArray()];
    NSInteger row;
    [self statusOfEntryEmotion: emotionValue withRow: &row];
    [picker selectRow: row inComponent: 0 animated: NO];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
    return self;
    
}

- (id)initWithSelectedWeatherCondition:(CDEntryWeatherCondition)weatherConditionValue temperature:(CDEntryTemerature)temperatureValue delegate:(id< UIContentPickerDelegate>)delegateValue {
    self = [[[NSBundle mainBundle] loadNibNamed: @"UIContentPicker" owner: self options: NULL] objectAtIndex: CTContentEmotionPicker];
    [self setFrame: CGRectCurrentDevice()];
    contentPicker = CTContentWeatherConditionPicker;
    delegate = delegateValue;
    array = [[NSArray alloc] initWithObjects: NSWeatherConditionArray(), NSTemperatureArray(), nil];
    NSInteger weatherCondition, temperature;
    [self statusOfEntryWeatherCondition: weatherConditionValue temperature: temperatureValue withWeatherCondition: &weatherCondition withTemperature: &temperature];
    [picker selectRow: weatherCondition inComponent: DIARY_ENTRY_weatherCondition animated: NO];
    [picker selectRow: temperature inComponent: DIARY_ENTRY_temperature animated: NO];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
    return self;
    
}

#pragma mark Return Functions > Pre-Defined Functions (PICKER VIEW)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (contentPicker) {
        case CTContentColorPicker: case CTContentEmotionPicker:
            return 1; break;
        case CTContentWeatherConditionPicker:
            return 2; break;
        default:
            return 0; break;
            
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (contentPicker) {
        case CTContentColorPicker: {
            switch (segTheme.selectedSegmentIndex) {
                case 0: case 1: case 2: case 3:
                    return [[NSColorArrayByTheme() objectAtIndex: component] count];
                case 4:
                    return 37; break;
                    
                default: return 0; break;
                    
            }
            break;
            
        } case CTContentEmotionPicker: {
            return [array count]; break;
            
        } case CTContentWeatherConditionPicker: {
            return [[array objectAtIndex: component] count]; break;
            
        } default: return 0; break;
            
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CVTableViewCellDefaultCellHeight;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    switch (contentPicker) {
        case CTContentColorPicker: {
            UILabel *label;
            if (!view)
                view = label = [[UILabel alloc] initWithFrame: CGRectMake( 0, 0, pickerView.frame.size.width, CVTableViewCellDefaultCellHeight)];
            [view setBackgroundColor: NSColorByTrait( [[[array objectAtIndex: segTheme.selectedSegmentIndex] objectAtIndex: row] intValue], 1)];
            [label setTextAlignment: NSTextAlignmentCenter];
            [label setText: NSTitleByColorTrait( [[[array objectAtIndex: segTheme.selectedSegmentIndex] objectAtIndex: row] intValue])];
            
            return view; break;
            
        } case CTContentEmotionPicker: {
            UILabel *label;
            UIImageView *image;
            if (!view) {
                view = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, pickerView.frame.size.width, CVTableViewCellDefaultCellHeight)];
                label = [[UILabel alloc] initWithFrame: view.frame]; [view addSubview: label];
                image = [[UIImageView alloc] initWithFrame: CGRectMake( 16, 1, CVDiaryEntryIconImageSize, CVDiaryEntryIconImageSize)]; [view addSubview: image];
                
            }
            [label setTextAlignment: NSTextAlignmentCenter];
            [label setText: NSTitleByEmotion( [[array objectAtIndex: row] intValue])];
            [image setImage: NSImageByEmotion( [[array objectAtIndex: row] intValue])];
            
            return view;
            
        } case CTContentWeatherConditionPicker: {
            UILabel *label;
            UIImageView *image;
            if (!view) {
                view = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, pickerView.frame.size.width/2, CVTableViewCellDefaultCellHeight)];
                label = [[UILabel alloc] initWithFrame: view.frame]; [view addSubview: label];
                image = [[UIImageView alloc] initWithFrame: CGRectMake( 8, 1, CVDiaryEntryIconImageSize, CVDiaryEntryIconImageSize)]; [view addSubview: image];
                
            }
            [label setTextAlignment: NSTextAlignmentCenter];
            switch (component) {
                case 0: { //WeatherCondition
                    [label setText: NSTitleByWeatherCondition( [[[array objectAtIndex: component] objectAtIndex: row] intValue])];
                    [image setImage: NSImageByWeatherCondition( [[[array objectAtIndex: component] objectAtIndex: row] intValue])];
                    break;
                    
                } case 1: { //Temperature
                    [label setText: NSTitleByTemperature( [[[array objectAtIndex: component] objectAtIndex: row] intValue])];
                    [image setImage: NSImageByTemperature( [[[array objectAtIndex: component] objectAtIndex: row] intValue])];
                    break;
                    
                }
                    
                default:
                    break;
            }
            
            return view; break;
            
        } default:
            return nil; break;
            
    }
    
}

#pragma mark - Void's

- (void)statusOfColor:(CDColorTraits)colorValue withSeg:(NSInteger *)segIndex withRow:(NSInteger *)rowIndex {
    for (int theme = 0; theme < 4; theme += 1) {
        for (int index = 0; index < [array[theme] count]; index += 1) {
            if ([array[theme][index] intValue] == colorValue) {
                *segIndex = theme;
                *rowIndex = index;
                break;
                
            }
            
        }
        
    }
    
}

- (void)statusOfEntryEmotion:(CDEntryEmotions)emotionValue withRow:(NSInteger *)rowIndex {
    for (int index = 0; index < [array count]; index += 1) {
        if ([array[index] intValue] == emotionValue) {
            *rowIndex = index;
            break;
            
        }
        
    }
    
}

- (void)statusOfEntryWeatherCondition:(CDEntryWeatherCondition)weatherConditionValue temperature:(CDEntryTemerature)temperatureValue withWeatherCondition:(NSInteger *)weatherConditionIndex withTemperature:(NSInteger *)temperatureIndex {
    for (int index = 0; index < [array[DIARY_ENTRY_weatherCondition] count]; index += 1) {
        if ([array[DIARY_ENTRY_weatherCondition][index] intValue] == weatherConditionValue) {
            *weatherConditionIndex = index;
            break;
            
        }
        
    }
    for (int index = 0; index < [array[DIARY_ENTRY_temperature] count]; index += 1) {
        if ([array[DIARY_ENTRY_temperature][index] intValue] == temperatureValue) {
            *temperatureIndex = index;
            break;
            
        }
        
    }
    
}

- (void)selectByTrait:(CDColorTraits)colorValue {
    NSInteger theme, row;
    [self statusOfColor: colorValue withSeg: &theme withRow: &row];
    [segTheme setSelectedSegmentIndex: theme];
    [picker selectRow: row inComponent: 0 animated: YES];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
    
}

#pragma mark Void's > Pre-Defined Functions (PICKER VIEW)

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (contentPicker) {
        case CTContentColorPicker:
            [button setTitle: NSTitleByColorTrait( NSColorTraitByIndex( [array[segTheme.selectedSegmentIndex][row] intValue])) forState: UIControlStateNormal];
            break;
        case CTContentEmotionPicker:
            [button setTitle: NSTitleByEmotion( [array[row] intValue]) forState: UIControlStateNormal];
            break;
        case CTContentWeatherConditionPicker: {
            [button setTitle: [NSString stringWithFormat: @"%@ : %@", NSTitleByWeatherCondition( [[array[DIARY_ENTRY_weatherCondition] objectAtIndex: [pickerView selectedRowInComponent: DIARY_ENTRY_weatherCondition]] intValue]), NSTitleByTemperature( [[array[DIARY_ENTRY_temperature] objectAtIndex: [pickerView selectedRowInComponent: DIARY_ENTRY_temperature]] intValue])] forState: UIControlStateNormal];
            break;
            
        }
            
        default:
            break;
    }
    
}

#pragma mark - IBActions

- (IBAction)changeSegTheme:(UISegmentedControl *)sender {
    [picker reloadComponent: 0];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
}

- (IBAction)pressDone:(id)sender {
    switch (contentPicker) {
        case CTContentColorPicker: {
            if ([delegate respondsToSelector: @selector( contentPicker:didFinishWithColor:)])
                [delegate contentPicker: self didFinishWithColor: NSColorTraitByIndex( [array[segTheme.selectedSegmentIndex][(int)[picker selectedRowInComponent: 0]] intValue])];
            break;
            
        } case CTContentEmotionPicker: {
            if ([delegate respondsToSelector: @selector( contentPicker:didFinishWithEntryEmotion:)])
                [delegate contentPicker: self didFinishWithEntryEmotion: [[array objectAtIndex: [picker selectedRowInComponent: 0]] intValue]];
            break;
            
        } case CTContentWeatherConditionPicker: {
            if ([delegate respondsToSelector: @selector( contentPicker:didFinishWithEntryWeatherCondition:temperature:)])
                [delegate contentPicker: self didFinishWithEntryWeatherCondition: [[array[DIARY_ENTRY_weatherCondition] objectAtIndex: [picker selectedRowInComponent: DIARY_ENTRY_weatherCondition]] intValue] temperature: [[array[DIARY_ENTRY_temperature] objectAtIndex: [picker selectedRowInComponent: DIARY_ENTRY_temperature]] intValue]];
            break;
            
        } default:
            break;
            
    }
    [self dismissAnimated: YES];
    
}

#pragma mark - View Lifecycle

- (void)showAnimated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations: NULL context: nil];
        [UIView setAnimationDuration: 0.25];
        [UIView setAnimationDelegate: delegate];
        [contentView setTransform: CGAffineTransformMakeTranslation( 0, -contentView.frame.size.height)];
        [UIView commitAnimations];
        
    }
    [[[[UIApplication sharedApplication] windows] objectAtIndex: 0] addSubview: self];
    
    isShowing = true;
    
}

- (void)dismissAnimated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations: NULL context: nil];
        [UIView setAnimationDuration: 0.25];
        [UIView setAnimationDidStopSelector: @selector( removeFromSuperview)];
        [UIView setAnimationDelegate: self];
        [contentView setTransform: CGAffineTransformMakeTranslation( 0, contentView.frame.size.height)];
        [self setAlpha: 0];
        [UIView commitAnimations];
        
    } else
        [self setTransform: CGAffineTransformMakeTranslation( 0, contentView.frame.size.height)];
    
    isShowing = false;
    
}

@end
