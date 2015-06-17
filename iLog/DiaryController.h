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

- (NSDictionary *)index;

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