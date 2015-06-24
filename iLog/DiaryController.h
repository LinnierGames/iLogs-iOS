//
//  DiaryController.h
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryController : NSObject

@end

#pragma mark - Diaries

#pragma mark NSArray category (ARRAY_Diaries_)

static const NSUInteger DIARY_title = 0;
static const NSUInteger DIARY_dateCreated = 1;

@interface NSArray (ARRAY_Diaries_)

+ (id)arrayNEWDiary;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue index:(NSMutableDictionary *)dicIndex;
- (NSString *)objectDiary_title;
- (NSDate *)objectDiary_dateCreated;

@end

#pragma mark UniversalFunctions category (SQL_DIARIES_)

static const int SQL_DIARY_id = 0;
static const int SQL_DIARY_title = 1;
static const int SQL_DIARY_dateCreated = 2;

/**
 * From the parameter list, an array is produced in Diary format
 * @param [in] statement incoming value from previous call SQLSTatementStep(..)
 * @return NSArray: Diary format
 */
static inline NSMutableArray * SQLStatementRowIntoDiaryEntry( sqlite3_stmt *statement) {
    NSString *stringTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_DIARY_title)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_DIARY_dateCreated)]];
    
    return [NSMutableArray arrayNEWDiaryWithTitle: stringTitle dateCreated: dateCreated index: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_DIARY_id)], @"id", nil]];
    
};

@interface UniversalFunctions (SQL_Diaries_)

/**
 * Inserts a row to the table Diaries
 * @param [in] arrayEntry: Diaries
 */
+ (void)SQL_DIARIES_voidInsertRowWithArray:(const NSArray *)arrayEntry;
/**
 * Updates an exisiting row to the table Diaries
 * @param [in] arrayEntry: Diaries
 */
+ (void)SQL_DIARIES_voidUpdateRowForArray:(const NSArray *)arrayEntry;
/**
 * Deletes a row to the table Diaries
 * @param [in] arrayEntry: Diaries
 */
+ (void)SQL_DIARIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry;

@end

#pragma mark UniversalVariables category (DIARIES_)

@interface UniversalVariables (DIARIES_)

- (void)DIARIES_writeNewForDiary:(NSArray *)arrayDiary;
- (void)DIARIES_updateForDiary:(NSArray *)arrayDiary;
- (void)DIARIES_deleteForDiary:(NSArray *)arrayDiary;

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
    CTEntryEmotionRecovering = 32,
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
    CTEntryEmotionAngry = 31
    
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
        case CTEntryEmotionRecovering:
            return [UIImage imageNamed: @"misc_emotionRecovering"]; break;
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
            return @"Strong or Well Fit"; break;
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
        case CTEntryEmotionRecovering:
            return @"Recovering"; break;
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
        default:
            return NSTitleByEmotion( CTEntryEmotionNoone); break;
            
    }
    
}

static inline NSArray* NSEmotionArray() {
    return [NSArray arrayWithObjects:
            @(CTEntryEmotionVeryHappy),
            @(CTEntryEmotionNoone),
            @(CTEntryEmotionVeryHappy),
            @(CTEntryEmotionHappy),
            @(CTEntryEmotionStrongWellFit),
            @(CTEntryEmotionDetermined),
            @(CTEntryEmotionAccomplished),
            @(CTEntryEmotionWondering),
            @(CTEntryEmotionProductive),
            @(CTEntryEmotionRelieved),
            @(CTEntryEmotionRecovering),
            @(CTEntryEmotionProud),
            @(CTEntryEmotionCool),
            @(CTEntryEmotionOkay),
            @(CTEntryEmotionNeutral),
            @(CTEntryEmotionMeh),
            @(CTEntryEmotionTired),
            @(CTEntryEmotionExhausted),
            @(CTEntryEmotionLazy),
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
    CTEntryWeatherConditionSnowy = 7
    
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
        default:
            return NSTitleByWeatherCondition( CTEntryWeatherConditionNoone); break;
            
    }
    
}

static inline NSArray* NSWeatherConditionArray() {
    return [NSArray arrayWithObjects:
            @(CTEntryWeatherConditionNoone),
            @(CTEntryWeatherConditionSunny),
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
            return @"JustRight"; break;
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

#pragma mark NSArray category (ARRAY_Entries_)

static const NSUInteger ENTRIES_subject = 0;
static const NSUInteger ENTRIES_date = 1;
static const NSUInteger ENTRIES_dateCreated = 2;
static const NSUInteger ENTRIES_body = 3;
static const NSUInteger ENTRIES_emotion = 4;
static const NSUInteger ENTRIES_weather = 5;
static const NSUInteger ENTRIES_isBookmarked = 6;
static const NSUInteger ENTRIES_hasImage = 7;
static const NSUInteger ENTRIES_hasAudioMemo = 8;

@interface NSArray (ARRAY_Entries_)

+ (id)arrayNEWEntry;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weather:(CDEntryWeatherCondition)weatherValue isBookmarked:(BOOL)boolBookmarkedValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weather:(CDEntryWeatherCondition)weatherValue isBookmarked:(BOOL)boolBookmarkedValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectEntry_subject;
- (NSDate *)objectEntry_date;
- (NSDate *)objectEntry_dateCreated;
- (NSString *)objectEntry_body;
- (CDEntryEmotions)objectEntry_emotion;
- (CDEntryWeatherCondition)objectEntry_weather;
- (BOOL)objectEntry_isBookmarked;
- (BOOL)objectEntry_hasImage;
- (BOOL)objectEntry_hasAudioMemo;

@end

#pragma mark UniversalFunctions category (SQL_Entries_)

static const int SQL_ENTRIES_id = 0;
static const int SQL_ENTRIES_diaryID = 1;
static const int SQL_ENTRIES_subject = 2;
static const int SQL_ENTRIES_date = 3;
static const int SQL_ENTRIES_dateCreated = 4;
static const int SQL_ENTRIES_body = 5;
static const int SQL_ENTRIES_emotion = 6;
static const int SQL_ENTRIES_weather = 7;
static const int SQL_ENTRIES_isBookmarked = 8;
static const int SQL_ENTRIES_hasImage = 9;
static const int SQL_ENTRIES_hasAudioMemo = 10;

/**
 * From the parameter list, an array is produced in Entry format
 * @param [in] statement incoming value from previous call SQLSTatementStep(..)
 * @return NSArray: Entry format
 */
static inline NSMutableArray * SQLStatementRowIntoEntryEntry( sqlite3_stmt *statement) {
    NSString *stringSubject = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_subject)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *date = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_date)]];
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_dateCreated)]];
    
    NSString *stringBody = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_body)];
    
    CDEntryEmotions emotion = sqlite3_column_int( statement, SQL_ENTRIES_emotion);
    CDEntryWeatherCondition weather = sqlite3_column_int( statement, SQL_ENTRIES_weather);
    BOOL isBookmarked = sqlite3_column_int( statement, SQL_ENTRIES_isBookmarked);
    BOOL hasImage = sqlite3_column_int( statement, SQL_ENTRIES_hasImage);
    BOOL hasAudioMemo = sqlite3_column_int( statement, SQL_ENTRIES_hasAudioMemo);
    
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubject date: date dateCreated: dateCreated body: stringBody emotion: emotion weather: weather isBookmarked: isBookmarked hasImage: hasImage hasAudioMemo: hasAudioMemo options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_ENTRIES_id)], @"id", [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_ENTRIES_diaryID)], @"diaryID", nil]];
    
};

@interface UniversalFunctions (SQL_Entries_)

/**
 * Inserts a row to the table Entries
 * @param [in] arrayEntry: Entries
 */
+ (void)SQL_ENTRIES_voidInsertRowWithArray:(const NSArray *)arrayEntry;
/**
 * Updates an exisiting row to the table Entries
 * @param [in] arrayEntry: Entries
 */
+ (void)SQL_ENTRIES_voidUpdateRowForArray:(const NSArray *)arrayEntry;
/**
 * Deletes a row to the table Entries
 * @param [in] arrayEntry: Entries
 */
+ (void)SQL_ENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry;

@end

#pragma mark UniversalVariables category (ENTRIES_)

@interface UniversalVariables (ENTRIES_)

- (void)ENTRIES_writeNewForEntry:(NSArray *)arrayEntry;
- (void)ENTRIES_updateForEntry:(NSArray *)arrayEntry;
- (void)ENTRIES_deleteForEntry:(NSArray *)arrayEntry;

@end