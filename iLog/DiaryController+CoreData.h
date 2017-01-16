//
//  DiaryController+CoreData.h
//  iLogs - Universal iOS
//
//  Created by Erick Sanchez on 1/11/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

#include "Diary-Model+CoreDataModel.h"

@interface UniversalFunctions (DIARY_COREDATA_)

+ (NSPersistentContainer *)viewStore;
+ (NSManagedObjectContext *)viewContext;

@end

#pragma mark - Diaries

static NSString *CVDiaryEntity = @"Diary";

@interface Diary (DIARY_COREDATA_)

+ (Diary *)diary;
+ (NSArray<Diary *> *)executeFetchRequest;

@end

#pragma mark - Entries

typedef NS_ENUM(int, CDEntryEmotions) {
    CTEntryEmotionNoone = 0,
    CTEntryEmotionVeryHappy = 1,
    CTEntryEmotionHappy = 2,
    CTEntryEmotionStrongWellFit = 3,
    CTEntryEmotionDetermined = 4,
    CTEntryEmotionAccomplished = 5,
    CTEntryEmotionWondering = 6,
    CTEntryEmotionProductive = 7,
    CTEntryEmotionRelieved = 8,
    CTEntryEmotionProud = 9,
    CTEntryEmotionCool = 10,
    CTEntryEmotionOkay = 11,
    CTEntryEmotionNeutral = 12,
    CTEntryEmotionMeh = 13,
    CTEntryEmotionTired = 14,
    CTEntryEmotionExhausted = 15,
    CTEntryEmotionLazy = 16,
    CTEntryEmotionWorried = 17,
    CTEntryEmotionShocked = 18,
    CTEntryEmotionDisappointed = 19,
    CTEntryEmotionAnnoyed = 20,
    CTEntryEmotionOverwhealmed = 21,
    CTEntryEmotionOutOfShape = 22,
    CTEntryEmotionInPain = 23,
    CTEntryEmotionSick = 24,
    CTEntryEmotionSad = 25,
    CTEntryEmotionUpset = 26,
    CTEntryEmotionUnhappy = 27,
    CTEntryEmotionDepressed = 29,
    CTEntryEmotionMad = 30,
    CTEntryEmotionAngry = 31,
    CTEntryEmotionRecovering = 32,
    CTEntryEmotionRelaxed = 33,
    CTEntryEmotionExcited = 34,
    CTEntryEmotionHungry = 35,
    CTEntryEmotionNervous = 36
    
};

static inline UIImage* NSImageByEmotion(CDEntryEmotions emotion) {
    switch (emotion) {
        case CTEntryEmotionNoone:
            return [UIImage imageNamed: @"misc_emotion-disabled"]; break;
        case CTEntryEmotionVeryHappy:
            return [UIImage imageNamed: @"misc_emotionVeryHappy"]; break;
        case CTEntryEmotionHappy:
            return [UIImage imageNamed: @"misc_emotionHappy"]; break;
        case CTEntryEmotionStrongWellFit:
            return [UIImage imageNamed: @"misc_emotionStrongWellFit"]; break;
        case CTEntryEmotionDetermined:
            return [UIImage imageNamed: @"misc_emotionDetermined"]; break;
        case CTEntryEmotionAccomplished:
            return [UIImage imageNamed: @"misc_emotionAccomplished"]; break;
        case CTEntryEmotionWondering:
            return [UIImage imageNamed: @"misc_emotionWondering"]; break;
        case CTEntryEmotionProductive:
            return [UIImage imageNamed: @"misc_emotionProductive"]; break;
        case CTEntryEmotionRelieved:
            return [UIImage imageNamed: @"misc_emotionRelieved"]; break;
        case CTEntryEmotionProud:
            return [UIImage imageNamed: @"misc_emotionProud"]; break;
        case CTEntryEmotionCool:
            return [UIImage imageNamed: @"misc_emotionCool"]; break;
        case CTEntryEmotionOkay:
            return [UIImage imageNamed: @"misc_emotionOkay"]; break;
        case CTEntryEmotionNeutral:
            return [UIImage imageNamed: @"misc_emotionNeutral"]; break;
        case CTEntryEmotionMeh:
            return [UIImage imageNamed: @"misc_emotionMeh"]; break;
        case CTEntryEmotionTired:
            return [UIImage imageNamed: @"misc_emotionTired"]; break;
        case CTEntryEmotionExhausted:
            return [UIImage imageNamed: @"misc_emotionExhausted"]; break;
        case CTEntryEmotionLazy:
            return [UIImage imageNamed: @"misc_emotionLazy"]; break;
        case CTEntryEmotionWorried:
            return [UIImage imageNamed: @"misc_emotionWorried"]; break;
        case CTEntryEmotionShocked:
            return [UIImage imageNamed: @"misc_emotionShocked"]; break;
        case CTEntryEmotionDisappointed:
            return [UIImage imageNamed: @"misc_emotionDisappointed"]; break;
        case CTEntryEmotionAnnoyed:
            return [UIImage imageNamed: @"misc_emotionAnnoyed"]; break;
        case CTEntryEmotionOverwhealmed:
            return [UIImage imageNamed: @"misc_emotionOverwhealmed"]; break;
        case CTEntryEmotionOutOfShape:
            return [UIImage imageNamed: @"misc_emotionOutOfShape"]; break;
        case CTEntryEmotionInPain:
            return [UIImage imageNamed: @"misc_emotionInPain"]; break;
        case CTEntryEmotionSick:
            return [UIImage imageNamed: @"misc_emotionSick"]; break;
        case CTEntryEmotionSad:
            return [UIImage imageNamed: @"misc_emotionSad"]; break;
        case CTEntryEmotionUpset:
            return [UIImage imageNamed: @"misc_emotionUpset"]; break;
        case CTEntryEmotionUnhappy:
            return [UIImage imageNamed: @"misc_emotionUnhappy"]; break;
        case CTEntryEmotionDepressed:
            return [UIImage imageNamed: @"misc_emotionDepressed"]; break;
        case CTEntryEmotionMad:
            return [UIImage imageNamed: @"misc_emotionMad"]; break;
        case CTEntryEmotionAngry:
            return [UIImage imageNamed: @"misc_emotionAngry"]; break;
        case CTEntryEmotionRecovering:
            return [UIImage imageNamed: @"misc_emotionRecovering"]; break;
        case CTEntryEmotionRelaxed:
            return [UIImage imageNamed: @"misc_emotionRelaxed"]; break;
        case CTEntryEmotionExcited:
            return [UIImage imageNamed: @"misc_emotionExcited"]; break;
        case CTEntryEmotionHungry:
            return [UIImage imageNamed: @"misc_emotionHungry"]; break;
        case CTEntryEmotionNervous:
            return [UIImage imageNamed: @"misc_emotionNervous"]; break;
        default:
            return NSImageByEmotion( CTEntryEmotionNoone); break;
            
    }
    
}

static inline NSString* NSTitleByEmotion(CDEntryEmotions emotion) {
    switch (emotion) {
        case CTEntryEmotionNoone:
            return @"None"; break;
        case CTEntryEmotionVeryHappy:
            return @"Very Happy"; break;
        case CTEntryEmotionHappy:
            return @"Happy"; break;
        case CTEntryEmotionStrongWellFit:
            return @"Well Fit"; break;
        case CTEntryEmotionDetermined:
            return @"Determined"; break;
        case CTEntryEmotionAccomplished:
            return @"Accomplished"; break;
        case CTEntryEmotionWondering:
            return @"Wondering"; break;
        case CTEntryEmotionProductive:
            return @"Productive"; break;
        case CTEntryEmotionRelieved:
            return @"Relieved"; break;
        case CTEntryEmotionProud:
            return @"Proud"; break;
        case CTEntryEmotionCool:
            return @"Cool"; break;
        case CTEntryEmotionOkay:
            return @"Okay"; break;
        case CTEntryEmotionNeutral:
            return @"Neutral"; break;
        case CTEntryEmotionMeh:
            return @"Meh"; break;
        case CTEntryEmotionTired:
            return @"Tired"; break;
        case CTEntryEmotionExhausted:
            return @"Exhausted"; break;
        case CTEntryEmotionLazy:
            return @"Lazy"; break;
        case CTEntryEmotionWorried:
            return @"Worried"; break;
        case CTEntryEmotionShocked:
            return @"Shocked"; break;
        case CTEntryEmotionDisappointed:
            return @"Disappointed"; break;
        case CTEntryEmotionAnnoyed:
            return @"Annoyed"; break;
        case CTEntryEmotionOverwhealmed:
            return @"Overwhealmed"; break;
        case CTEntryEmotionOutOfShape:
            return @"Out of Shape"; break;
        case CTEntryEmotionInPain:
            return @"In Pain"; break;
        case CTEntryEmotionSick:
            return @"Sick"; break;
        case CTEntryEmotionSad:
            return @"Sad"; break;
        case CTEntryEmotionUpset:
            return @"Upset"; break;
        case CTEntryEmotionUnhappy:
            return @"Unhappy"; break;
        case CTEntryEmotionDepressed:
            return @"Depressed"; break;
        case CTEntryEmotionMad:
            return @"Mad"; break;
        case CTEntryEmotionAngry:
            return @"Angry"; break;
        case CTEntryEmotionRecovering:
            return @"Recovering"; break;
        case CTEntryEmotionRelaxed:
            return @"Relaxed"; break;
        case CTEntryEmotionExcited:
            return @"Excited"; break;
        case CTEntryEmotionHungry:
            return @"Hungry"; break;
        case CTEntryEmotionNervous:
            return @"Nervous"; break;
        default:
            return NSTitleByEmotion( CTEntryEmotionNoone); break;
            
    }
    
}

static inline NSArray* NSEmotionArray() {
    return [NSArray arrayWithObjects:
            @(CTEntryEmotionNoone),
            @(CTEntryEmotionVeryHappy),
            @(CTEntryEmotionHappy),
            @(CTEntryEmotionStrongWellFit),
            @(CTEntryEmotionDetermined),
            @(CTEntryEmotionAccomplished),
            @(CTEntryEmotionExcited),
            @(CTEntryEmotionWondering),
            @(CTEntryEmotionProductive),
            @(CTEntryEmotionRelieved),
            @(CTEntryEmotionRecovering),
            @(CTEntryEmotionRelaxed),
            @(CTEntryEmotionProud),
            @(CTEntryEmotionCool),
            @(CTEntryEmotionOkay),
            @(CTEntryEmotionNeutral),
            @(CTEntryEmotionMeh),
            @(CTEntryEmotionTired),
            @(CTEntryEmotionHungry),
            @(CTEntryEmotionExhausted),
            @(CTEntryEmotionLazy),
            @(CTEntryEmotionNervous),
            @(CTEntryEmotionWorried),
            @(CTEntryEmotionShocked),
            @(CTEntryEmotionDisappointed),
            @(CTEntryEmotionAnnoyed),
            @(CTEntryEmotionOverwhealmed),
            @(CTEntryEmotionOutOfShape),
            @(CTEntryEmotionInPain),
            @(CTEntryEmotionSick),
            @(CTEntryEmotionSad),
            @(CTEntryEmotionUpset),
            @(CTEntryEmotionUnhappy),
            @(CTEntryEmotionDepressed),
            @(CTEntryEmotionMad),
            @(CTEntryEmotionAngry), nil];
    
}

typedef NS_ENUM(int, CDEntryWeatherCondition) {
    CTEntryWeatherConditionNoone = 0,
    CTEntryWeatherConditionSunny = 1,
    CTEntryWeatherConditionCloudy = 2,
    CTEntryWeatherConditionWindy = 3,
    CTEntryWeatherConditionFoggy = 4,
    CTEntryWeatherConditionMisty = 5,
    CTEntryWeatherConditionRainy = 6,
    CTEntryWeatherConditionSnowy = 7,
    CTEntryWeatherConditionClear = 8
    
};

static inline UIImage* NSImageByWeatherCondition(CDEntryWeatherCondition weatherCondition) {
    switch (weatherCondition) {
        case CTEntryWeatherConditionNoone:
            return [UIImage imageNamed: @"misc_weather-disabled"]; break;
        case CTEntryWeatherConditionSunny:
            return [UIImage imageNamed: @"misc_weatherSunny"]; break;
        case CTEntryWeatherConditionCloudy:
            return [UIImage imageNamed: @"misc_weatherCloudy"]; break;
        case CTEntryWeatherConditionWindy:
            return [UIImage imageNamed: @"misc_weatherWindy"]; break;
        case CTEntryWeatherConditionFoggy:
            return [UIImage imageNamed: @"misc_weatherFoggy"]; break;
        case CTEntryWeatherConditionMisty:
            return [UIImage imageNamed: @"misc_weatherMisty"]; break;
        case CTEntryWeatherConditionRainy:
            return [UIImage imageNamed: @"misc_weatherRainy"]; break;
        case CTEntryWeatherConditionSnowy:
            return [UIImage imageNamed: @"misc_weatherSnowy"]; break;
        case CTEntryWeatherConditionClear:
            return [UIImage imageNamed: @"misc_weatherClear"]; break;
        default:
            return NSImageByWeatherCondition( CTEntryWeatherConditionNoone); break;
            
    }
    
}

static inline NSString* NSTitleByWeatherCondition(CDEntryWeatherCondition weatherCondition) {
    switch (weatherCondition) {
        case CTEntryWeatherConditionNoone:
            return @"None"; break;
        case CTEntryWeatherConditionSunny:
            return @"Sunny"; break;
        case CTEntryWeatherConditionCloudy:
            return @"Cloudy"; break;
        case CTEntryWeatherConditionWindy:
            return @"Windy"; break;
        case CTEntryWeatherConditionFoggy:
            return @"Foggy"; break;
        case CTEntryWeatherConditionMisty:
            return @"Misty"; break;
        case CTEntryWeatherConditionRainy:
            return @"Rainy"; break;
        case CTEntryWeatherConditionSnowy:
            return @"Snowy"; break;
        case CTEntryWeatherConditionClear:
            return @"Clear"; break;
        default:
            return NSTitleByWeatherCondition( CTEntryWeatherConditionNoone); break;
            
    }
    
}

static inline NSArray* NSWeatherConditionArray() {
    return [NSArray arrayWithObjects:
            @(CTEntryWeatherConditionNoone),
            @(CTEntryWeatherConditionSunny),
            @(CTEntryWeatherConditionClear),
            @(CTEntryWeatherConditionCloudy),
            @(CTEntryWeatherConditionWindy),
            @(CTEntryWeatherConditionFoggy),
            @(CTEntryWeatherConditionMisty),
            @(CTEntryWeatherConditionRainy),
            @(CTEntryWeatherConditionSnowy), nil];
    
}

typedef NS_ENUM(int, CDEntryTemerature) {
    CTEntryTemperatureNoone = 0,
    CTEntryTemperatureHot = 1,
    CTEntryTemperatureHumid = 2,
    CTEntryTemperatureWarm = 3,
    CTEntryTemperatureJustRight = 4,
    CTEntryTemperatureCool = 5,
    CTEntryTemperatureCold = 6,
    CTEntryTemperatureFreezing = 7
    
};

static inline UIImage* NSImageByTemperature(CDEntryTemerature temperature) {
    switch (temperature) {
        case CTEntryTemperatureNoone:
            return [UIImage imageNamed: @"misc_temperature-disabled"]; break;
        case CTEntryTemperatureHot:
            return [UIImage imageNamed: @"misc_temperatureHot"]; break;
        case CTEntryTemperatureHumid:
            return [UIImage imageNamed: @"misc_temperatureHumid"]; break;
        case CTEntryTemperatureWarm:
            return [UIImage imageNamed: @"misc_temperatureWarm"]; break;
        case CTEntryTemperatureJustRight:
            return [UIImage imageNamed: @"misc_temperatureJustRight"]; break;
        case CTEntryTemperatureCool:
            return [UIImage imageNamed: @"misc_temperatureCool"]; break;
        case CTEntryTemperatureCold:
            return [UIImage imageNamed: @"misc_temperatureCold"]; break;
        case CTEntryTemperatureFreezing:
            return [UIImage imageNamed: @"misc_temperatureFreezing"]; break;
        default:
            return NSImageByTemperature( CTEntryTemperatureNoone); break;
            
    }
    
}


static inline NSString* NSTitleByTemperature(CDEntryTemerature temperature) {
    switch (temperature) {
        case CTEntryTemperatureNoone:
            return @"None"; break;
        case CTEntryTemperatureHot:
            return @"Hot"; break;
        case CTEntryTemperatureHumid:
            return @"Humid"; break;
        case CTEntryTemperatureWarm:
            return @"Warm"; break;
        case CTEntryTemperatureJustRight:
            return @"Just Right"; break;
        case CTEntryTemperatureCool:
            return @"Cool"; break;
        case CTEntryTemperatureCold:
            return @"Cold"; break;
        case CTEntryTemperatureFreezing:
            return @"Freezing"; break;
        default:
            return NSTitleByTemperature( CTEntryTemperatureNoone); break;
            
    }
    
}

static inline NSArray* NSTemperatureArray() {
    return [NSArray arrayWithObjects:
            @(CTEntryTemperatureNoone),
            @(CTEntryTemperatureHot),
            @(CTEntryTemperatureHumid),
            @(CTEntryTemperatureWarm),
            @(CTEntryTemperatureJustRight),
            @(CTEntryTemperatureCool),
            @(CTEntryTemperatureCold),
            @(CTEntryTemperatureFreezing), nil];
    
}

static NSString *CVEntryEntity = @"Entry";

@interface Entry (DIARY_COREDATA_)

+ (Entry *)entry;

@end

#pragma mark NSDate category (COLOR_)

@interface NSDate (COLOR_)

- (UIColor *)dayNightColorByTimeOfDay;

@end
