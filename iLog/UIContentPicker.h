//
//  UIContentPicker.h
//  iLog
//
//  Created by Erick Sanchez on 6/22/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryController.h"

@protocol UIContentPickerDelegate;

typedef NS_ENUM(NSUInteger, CDContentPicker) {
    CTColorPicker,
    CTEmotionPicker,
    CTWeatherConditionPicker,
    CTTemperaturePicker,
    CTIconPicker
    
};

@interface UIContentPicker : UIView

@property ( assign) id< UIContentPickerDelegate>  delegate;
@property ( readonly) BOOL isShowing;

- (id)initWithSelectedColor:(CDColorTraits)colorValue delegate:(id< UIContentPickerDelegate>)delegateValue;
- (id)initWithSelectedEmotion:(CDEntryEmotions)emotionValue delegate:(id< UIContentPickerDelegate>)delegateValue;
- (id)initWithSelectedWeatherCondition:(CDEntryWeatherCondition)emotionValue delegate:(id< UIContentPickerDelegate>)delegateValue;
- (id)initWithSelectedTemperature:(CDEntryEmotions)emotionValue delegate:(id< UIContentPickerDelegate>)delegateValue;
- (void)showAnimated:(BOOL)animated;
- (void)selectByTrait:(CDColorTraits)colorValue;
- (void)dismissAnimated:(BOOL)animated;

@end

@protocol UIContentPickerDelegate <NSObject>

- (void)colorPicker:(UIContentPicker *)colorPicker didFinishWithColor:(CDColorTraits)selectedColor;

- (void)colorPickerWillAppear:(UIContentPicker *)colorPicker;
- (void)colorPickerDidAppear:(UIContentPicker *)colorPicker;
- (void)colorPickerWillDisappear:(UIContentPicker *)colorPicker;
- (void)colorPickerDidDisappear:(UIContentPicker *)colorPicker;

@end
