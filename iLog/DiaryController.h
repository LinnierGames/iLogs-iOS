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

@interface NSArray (ARRAY_)

- (NSDictionary *)options;

@end

static const NSUInteger DIARY_title;
static const NSUInteger DIARY_dateCreated;

@interface NSArray (ARRAY_Diaries_)

+ (id)arrayNEWDiary;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue index:(NSDictionary *)dicIndex;
- (NSString *)objectDiary_title;
- (NSDate *)objectDiary_dateCreated;

@end

static const int SQL_DIARY_id;
static const int SQL_DIARY_title;
static const int SQL_DIARY_dateCreated;

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
    
    return [NSMutableArray arrayNEWDiaryWithTitle: stringTitle dateCreated: dateCreated index: @{@"index": [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_DIARY_id)]}];
    
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

static const NSUInteger ENTRIES_subject;
static const NSUInteger ENTRIES_body;
static const NSUInteger ENTRIES_hasImage;
static const NSUInteger ENTRIES_hasAudioMemo;
static const NSUInteger ENTRIES_isBookmarked;
static const NSUInteger ENTRIES_date;
static const NSUInteger ENTRIES_dateCreated;

@interface NSArray (ARRAY_Entries_)

+ (id)arrayNEWEntry;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue isBookmarked:(BOOL)boolBookmarkedValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue isBookmarked:(BOOL)boolBookmarkedValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue index:(NSDictionary *)dicIndex;
- (NSString *)objectEntry_subject;
- (NSString *)objectEntry_body;
- (BOOL)objectEntry_hasImage;
- (BOOL)objectEntry_hasAudioMemo;
- (BOOL)objectEntry_isBookmarked;
- (NSDate *)objectEntry_date;
- (NSDate *)objectEntry_dateCreated;

@end

static const int SQL_ENTRIES_id;
static const int SQL_ENTRIES_diaryID;
static const int SQL_ENTRIES_subject;
static const int SQL_ENTRIES_body;
static const int SQL_ENTRIES_hasImage;
static const int SQL_ENTRIES_hasAudioMemo;
static const int SQL_ENTRIES_isBookmarked;
static const int SQL_ENTRIES_date;
static const int SQL_ENTRIES_dateCreated;

/**
 * From the parameter list, an array is produced in Entry format
 * @param [in] statement incoming value from previous call SQLSTatementStep(..)
 * @return NSArray: Entry format
 */
static inline NSMutableArray * SQLStatementRowIntoEntryEntry( sqlite3_stmt *statement) {
    NSString *stringSubject = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_subject)];
    NSString *stringBody = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_body)];
    BOOL hasImage = sqlite3_column_int( statement, SQL_ENTRIES_hasImage);
    BOOL hasAudioMemo = sqlite3_column_int( statement, SQL_ENTRIES_hasAudioMemo);
    BOOL isBookmarked = sqlite3_column_int( statement, SQL_ENTRIES_isBookmarked);
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *date = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_date)]];
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_dateCreated)]];
    
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubject body: stringBody hasImage: hasImage hasAudioMemo: hasAudioMemo isBookmarked: isBookmarked date: date dateCreated: dateCreated index: @{@"id": [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_ENTRIES_id)], @"diaryID": [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_ENTRIES_diaryID)]}];
    
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