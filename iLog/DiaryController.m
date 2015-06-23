//
//  DiaryController.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "DiaryController.h"

@implementation DiaryController

@end

#pragma mark - Entries

#pragma mark NSArray category (ARRAY_Diaries_)

@implementation NSArray (ARRAY_Diaries_)

+ (id)arrayNEWDiary {
    return [NSMutableArray arrayNEWDiaryWithTitle: @"Untitled" dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWDiaryWithTitle: stringTitleValue dateCreated: dateCreatedValue index: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue index:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringTitleValue, dateCreatedValue, dicIndex, nil];
    
}

- (NSString *)objectDiary_title {
    return [self objectAtIndex: DIARY_title];
    
}

- (NSDate *)objectDiary_dateCreated {
    return [self objectAtIndex: DIARY_dateCreated];
    
}

@end

#pragma mark UniversalFunctions category (SQL_DIARIES_)

@implementation UniversalFunctions (SQL_Diaries_)

+ (void)SQL_DIARIES_voidInsertRowWithArray:(const NSArray *)arrayEntry {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries withDatabase: &database]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Diaries (title, dateCreated) values (\"%@\", \"%@\");", [[arrayEntry objectDiary_title] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]]];
        char *err;
        if (!SQLQueryMake( database, sqlStatement, &err)) {
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"***Failed to Add to Table: +SQL_DIARIES_voidInsertRowWithArray:");
            
        } else
            NSLog( @"Added to Table: %@: +SQL_DIARIES_voidInsertRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_DIARIES_voidUpdateRowForArray:(const NSArray *)arrayEntry {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries withDatabase: &database]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Diaries SET title = \"%@\", dateCreated = \"%@\" where id = %lu;", [[arrayEntry objectDiary_title] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]], [[[arrayEntry options] objectForKey: @"id"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( database, sqlStatement, &err)) {
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"***Failed to Update row: +SQL_DIARIES_voidUpdateRowForArray:");
            
        } else
            NSLog( @"Updated row: %@: +SQL_DIARIES_voidUpdateRowForArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_DIARIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries withDatabase: &database]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Diaries where id = %lu;", [[[arrayEntry options] objectForKey: @"id"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( database, sqlStatement, &err)) {
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"***Failed to Delete row: +SQL_DIARIES_voidDeleteRowWithArray:");
            
        } else
            NSLog( @"Deleted row: %@: +SQL_DIARIES_voidDeleteRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

@end

#pragma mark UniversalVariables category (DIARIES_)

@implementation UniversalVariables (DIARIES_)

- (void)DIARIES_writeNewForDiary:(NSArray *)arrayDiary {
    [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayDiary];
    
}

- (void)DIARIES_updateForDiary:(NSArray *)arrayDiary {
    [UniversalFunctions SQL_DIARIES_voidUpdateRowForArray: arrayDiary];
    
}

- (void)DIARIES_deleteForDiary:(NSArray *)arrayDiary {
    [UniversalFunctions SQL_DIARIES_voidDeleteRowWithArray: arrayDiary];
    
}

@end

#pragma mark - Entries

#pragma mark NSArray category (ARRAY_Entries_)

@implementation NSArray (ARRAY_Entries_)

+ (id)arrayNEWEntry {
    return [NSMutableArray arrayNEWEntryWithSubject: @"" body: @""];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue date: [NSDate date] dateCreated: [NSDate date] body: stringBodyValue emotion: CTEntryEmotionNoone weather: CTEntryWeatherConditionNoone isBookmarked: NO hasImage: NO hasAudioMemo: NO];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weather:(CDEntryWeatherCondition)weatherValue isBookmarked:(BOOL)boolBookmarkedValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue date: dateValue dateCreated: dateCreatedValue body: stringBodyValue emotion: emotionValue weather: weatherValue isBookmarked: boolBookmarkedValue hasImage: boolImageValue hasAudioMemo: boolAudioMemoValue options: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weather:(CDEntryWeatherCondition)weatherValue isBookmarked:(BOOL)boolBookmarkedValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringSubjectValue, dateValue, dateCreatedValue, stringBodyValue, [NSNumber numberWithInt: emotionValue], [NSNumber numberWithInt: weatherValue], [NSNumber numberWithBool: boolBookmarkedValue], [NSNumber numberWithBool: boolImageValue], [NSNumber numberWithBool: boolAudioMemoValue], dicIndex, nil];
    
}

- (NSString *)objectEntry_subject {
    return [self objectAtIndex: ENTRIES_subject];
    
}

- (NSDate *)objectEntry_date {
    return [self objectAtIndex: ENTRIES_date];
    
}

- (NSDate *)objectEntry_dateCreated {
    return [self objectAtIndex: ENTRIES_dateCreated];
    
}

- (NSString *)objectEntry_body {
    return [self objectAtIndex: ENTRIES_body];
    
}

- (BOOL)objectEntry_isBookmarked {
    return [[self objectAtIndex: ENTRIES_isBookmarked] boolValue];
    
}

- (CDEntryEmotions)objectEntry_emotion {
    return [[self objectAtIndex: ENTRIES_emotion] intValue];
    
}

- (CDEntryWeatherCondition)objectEntry_weather {
    return [[self objectAtIndex: ENTRIES_weather] intValue];
    
}

- (BOOL)objectEntry_hasImage {
    return [[self objectAtIndex: ENTRIES_hasImage] boolValue];
    
}

- (BOOL)objectEntry_hasAudioMemo {
    return [[self objectAtIndex: ENTRIES_hasAudioMemo] boolValue];
    
}


@end

#pragma mark UniversalFunctions category (SQL_Entries_)

@implementation UniversalFunctions (SQL_Entries_)

+ (void)SQL_ENTRIES_voidInsertRowWithArray:(const NSArray *)arrayEntry {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLEntries withDatabase: &database]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Entries (subject, date, dateCreated, body, emotion, weather, isBookmarked, hasImage, hasAudioMemo, diaryID) values (\"%@\", \"%@\", \"%@\", \"%@\", %d, %d, %d, %d, %d, %lu);", [[arrayEntry objectEntry_subject] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[arrayEntry objectEntry_body] reformatForSQLQuries], [arrayEntry objectEntry_emotion], [arrayEntry objectEntry_weather], [arrayEntry objectEntry_isBookmarked], [arrayEntry objectEntry_hasImage], [arrayEntry objectEntry_hasAudioMemo], [[[arrayEntry options] objectForKey: @"diaryID"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( database, sqlStatement, &err)) {
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"***Failed to Add to Table: +SQL_ENTRIES_voidInsertRowWithArray:");
            
        } else
            NSLog( @"Added to Table: %@: +SQL_ENTRIES_voidInsertRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_ENTRIES_voidUpdateRowForArray:(const NSArray *)arrayEntry {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLEntries withDatabase: &database]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Entries SET subject = \"%@\", date = \"%@\", dateCreated = \"%@\", body = \"%@\", emotion = %d, weather = %d, isBookmarked = %d, hasImage = %d, hasAudioMemo = %d, diaryID = %lu where id = %lu;", [[arrayEntry objectEntry_subject] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[arrayEntry objectEntry_body] reformatForSQLQuries], [arrayEntry objectEntry_emotion], [arrayEntry objectEntry_weather], [arrayEntry objectEntry_isBookmarked], [arrayEntry objectEntry_hasImage], [arrayEntry objectEntry_hasAudioMemo], [[[arrayEntry options] objectForKey: @"diaryID"] unsignedLongValue], [[[arrayEntry options] objectForKey: @"id"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( database, sqlStatement, &err)) {
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"***Failed to Update row: +SQL_ENTRIES_voidUpdateRowForArray:");
            
        } else
            NSLog( @"Updated row: %@: +SQL_ENTRIES_voidUpdateRowForArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_ENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLEntries withDatabase: &database]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Entries where id = %lu;", [[[arrayEntry options] objectForKey: @"id"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( database, sqlStatement, &err)) {
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"***Failed to Delete row: +SQL_ENTRIES_voidDeleteRowWithArray:");
            
        } else
            NSLog( @"Deleted row: %@: +SQL_ENTRIES_voidDeleteRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

@end

#pragma mark UniversalVariables category (ENTRIES_)

@implementation UniversalVariables (ENTRIES_)

- (void)ENTRIES_writeNewForEntry:(NSArray *)arrayEntry {
    [UniversalFunctions SQL_ENTRIES_voidInsertRowWithArray: arrayEntry];
    
}

- (void)ENTRIES_updateForEntry:(NSArray *)arrayEntry {
    [UniversalFunctions SQL_ENTRIES_voidUpdateRowForArray: arrayEntry];
    
}

- (void)ENTRIES_deleteForEntry:(NSArray *)arrayEntry {
    [UniversalFunctions SQL_ENTRIES_voidDeleteRowWithArray: arrayEntry];
    
}

@end
