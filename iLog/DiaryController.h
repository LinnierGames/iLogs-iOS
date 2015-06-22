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
    CTEntryEmotionHappy = 1,
    CTEntryEmotionNeutral = 2,
    CTEntryEmotionUnhappy = 3,
    CTEntryEmotionMad = 4
};

typedef NS_ENUM(int, CDEntryWeather) {
    CTEntryWeatherNoone = 0,
    CTEntryWeatherClear = 1,
    CTEntryWeatherCouldy = 2,
    CTEntryWeatherWindy = 3,
    CTEntryWeatherRainy = 4,
    CTEntryWeatherSnowy = 5,
    
};

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
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weather:(CDEntryWeather)weatherValue isBookmarked:(BOOL)boolBookmarkedValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weather:(CDEntryWeather)weatherValue isBookmarked:(BOOL)boolBookmarkedValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectEntry_subject;
- (NSDate *)objectEntry_date;
- (NSDate *)objectEntry_dateCreated;
- (NSString *)objectEntry_body;
- (CDEntryEmotions)objectEntry_emotion;
- (CDEntryWeather)objectEntry_weather;
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
    CDEntryWeather weather = sqlite3_column_int( statement, SQL_ENTRIES_weather);
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