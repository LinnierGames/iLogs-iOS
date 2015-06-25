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
    CTContentColorPicker = 0,
    CTContentEmotionPicker = 1,
    CTContentWeatherConditionPicker = 2,
    CTContentTemperaturePicker = 3,
    CTContentIconPicker = 4
    
};

@interface UIContentPicker : UIView

@property ( assign) id< UIContentPickerDelegate>  delegate;
@property ( assign) CDContentPicker contentPicker;
@property ( readonly) BOOL isShowing;

- (id)initWithSelectedColor:(CDColorTraits)colorValue delegate:(id< UIContentPickerDelegate>)delegateValue;
- (id)initWithSelectedEmotion:(CDEntryEmotions)emotionValue delegate:(id< UIContentPickerDelegate>)delegateValue;
- (id)initWithSelectedWeatherCondition:(CDEntryWeatherCondition)weatherConditionValue temperature:(CDEntryTemerature)temperatureValue delegate:(id< UIContentPickerDelegate>)delegateValue;

- (void)showAnimated:(BOOL)animated;
- (void)selectByTrait:(CDColorTraits)colorValue;
- (void)dismissAnimated:(BOOL)animated;

@end

@protocol UIContentPickerDelegate <NSObject>

- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithColor:(CDColorTraits)selectedColor;
- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithEntryEmotion:(CDEntryEmotions)selectedEmotion;
- (void)contentPicker:(UIContentPicker *)contentPicker didFinishWithEntryWeatherCondition:(CDEntryWeatherCondition)selectedWeatherCondition temperature:(CDEntryTemerature)selectedTemperature;

- (void)colorPickerWillAppear:(UIContentPicker *)colorPicker;
- (void)colorPickerDidAppear:(UIContentPicker *)colorPicker;
- (void)colorPickerWillDisappear:(UIContentPicker *)colorPicker;
- (void)colorPickerDidDisappear:(UIContentPicker *)colorPicker;

@end
