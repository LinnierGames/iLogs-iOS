//
//  UIContentPicker.m
//  iLog
//
//  Created by Erick Sanchez on 6/22/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UIContentPicker.h"

@interface UIContentPicker () < UIPickerViewDataSource, UIPickerViewDelegate> {
    IBOutlet UIView *contentView;
    IBOutlet UIPickerView *picker;
    IBOutlet UISegmentedControl *segTheme;
    IBOutlet UIButton *button;
    
    const NSArray *array;
    
}

@end

@implementation UIContentPicker
@synthesize delegate, isShowing;

#pragma mark - Return Functions

- (id)initWithSelectedColor:(CDColorTraits)colorValue delegate:(id< UIContentPickerDelegate>)delegateValue {
    self = [[[NSBundle mainBundle] loadNibNamed: @"UIContentPicker" owner: self options: NULL] objectAtIndex: 0];
    delegate = delegateValue;
    array = NSColorArrayByTheme();
    NSInteger theme, row;
    [self statusOfColor: colorValue withSeg: &theme withRow: &row];
    [segTheme setSelectedSegmentIndex: theme];
    [picker selectRow: row inComponent: 0 animated: NO];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
    return self;
    
}

#pragma mark Return Functions > Pre-Defined Functions (PICKER VIEW)

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (segTheme.selectedSegmentIndex) {
        case 0: case 1: case 2: case 3:
            return [[NSColorArrayByTheme() objectAtIndex: component] count];
        case 4:
            return 37; break;
            
        default: return 0; break;
            
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return CVTableViewCellDefaultCellHeight;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    static UILabel *labelContent = nil;
    if (!view) {
        view = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, 320, CVTableViewCellDefaultCellHeight)];
        labelContent = [[UILabel alloc] initWithFrame: view.frame];
        [labelContent setText: @"Label"];
        [labelContent setTextAlignment: NSTextAlignmentCenter];
        //        [view addSubview: labelContent];
        
    }
    [labelContent setText: NSTitleByColorTrait( NSColorTraitByIndex( [array[segTheme.selectedSegmentIndex][row] intValue]))];
    [view setBackgroundColor: NSColorByTrait( NSColorTraitByIndex( [array[segTheme.selectedSegmentIndex][row] intValue]), 1)];
    
    return view;
    
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

- (void)selectByTrait:(CDColorTraits)colorValue {
    NSInteger theme, row;
    [self statusOfColor: colorValue withSeg: &theme withRow: &row];
    [segTheme setSelectedSegmentIndex: theme];
    [picker selectRow: row inComponent: 0 animated: YES];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
    
}

#pragma mark Void's > Pre-Defined Functions (PICKER VIEW)

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [button setTitle: NSTitleByColorTrait( NSColorTraitByIndex( [array[segTheme.selectedSegmentIndex][row] intValue])) forState: UIControlStateNormal];
    
}

#pragma mark - IBActions

- (IBAction)changeSegTheme:(UISegmentedControl *)sender {
    [picker reloadComponent: 0];
    [self pickerView: picker didSelectRow: [picker selectedRowInComponent: 0] inComponent: 0];
    
}

- (IBAction)pressDone:(id)sender {
    if ([delegate respondsToSelector: @selector( colorPicker:didFinishWithColor:)]) {
        [delegate colorPicker: self didFinishWithColor: NSColorTraitByIndex( [array[segTheme.selectedSegmentIndex][(int)[picker selectedRowInComponent: 0]] intValue])];
        
    }
    [self dismissAnimated: YES];
    
}

#pragma mark - View Lifecycle

- (void)showAnimated:(BOOL)animated {
    if (animated) {
        [contentView setCenter: CGPointMake( 160, 480 + contentView.frame.size.height/2)];
        
        [UIView beginAnimations: NULL context: nil];
        [UIView setAnimationDuration: 0.25];
        [UIView setAnimationDelegate: delegate];
        [contentView setCenter: CGPointMake( 160, 480 - contentView.frame.size.height/2)];
        [UIView commitAnimations];
        
    } else {
        [contentView setCenter: CGPointMake( 160, 480 - contentView.frame.size.height/2)];
        
    }
    [[[[UIApplication sharedApplication] windows] objectAtIndex: 0] addSubview: self];
    
    isShowing = true;
    
}


- (void)dismissAnimated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations: NULL context: nil];
        [UIView setAnimationDuration: 0.25];
        [UIView setAnimationDelegate: self];
        [contentView setTransform: CGAffineTransformMakeTranslation( 0, +contentView.frame.size.height)];
        [self setAlpha: 0];
        [UIView commitAnimations];
        
    } else
        [self setTransform: CGAffineTransformMakeTranslation( 0, +contentView.frame.size.height)];
    
    isShowing = false;
    [NSTimer scheduledTimerWithTimeInterval: 0.25 target: self selector: @selector( removeFromSuperview) userInfo: nil repeats: NO];
    
}

@end
