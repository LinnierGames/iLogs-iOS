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
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Diaries (title, dateCreated) values (\"%@\", \"%@\");", [[arrayEntry objectDiary_title] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_DIARIES_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_DIARIES_voidInsertRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_DIARIES_voidUpdateRowForArray:(const NSArray *)arrayEntry {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Diaries SET title = \"%@\", dateCreated = \"%@\" where id = %lu;", [[arrayEntry objectDiary_title] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]], [[[arrayEntry optionsDictionary] objectForKey: @"id"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Update row: +SQL_DIARIES_voidUpdateRowForArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Updated row: %@: +SQL_DIARIES_voidUpdateRowForArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_DIARIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Diaries where id = %lu;", [[[arrayEntry optionsDictionary] objectForKey: @"id"] unsignedLongValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Delete row: +SQL_DIARIES_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
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

- (NSArray *)DIARIES_returnFirstDiary {
    return [[UniversalFunctions SQL_returnContentsOfTable: CTSQLDiaries] objectAtIndex: 0];
    
}

- (NSMutableDictionary *)DIARIES_returnDiaryOptionsForDiary:(NSArray *)arrayDiary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary: [arrayDiary optionsDictionary]];
    
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries]) {
        NSLog( @"Table OK: +DIARIES_returnEntriesOptionsForDiary:");
        sqlite3_stmt *statement; const char *err;
        
        if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Entries where diaryID = %d", [[[arrayDiary optionsDictionary] objectForKey: @"id"] intValue]], &statement, &err)) {
            NSMutableArray *arrayEntries = [NSMutableArray array];
            while (SQLStatementStep( statement)) {
                [arrayEntries addObject: SQLStatementRowIntoEntryEntry( statement)];
                
            }
            [dictionary setValue: arrayEntries forKey: @"entries"];
            
        } else {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        }
        
        return dictionary;
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        return [[UniversalVariables globalVariables] DIARIES_returnDiaryOptionsForDiary: arrayDiary];
        
    }
    
    
}

@end

#pragma mark - Entries

#pragma mark NSArray category (ARRAY_Entries_)

@implementation NSArray (ARRAY_Entries_)

+ (id)arrayNEWEntry {
    return [NSMutableArray arrayNEWEntryWithSubject: @"" body: @""];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue date: [NSDate date] dateCreated: [NSDate date] body: stringBodyValue emotion: CTEntryEmotionNoone weatherCondition: CTEntryWeatherConditionNoone temperature: CTEntryTemperatureNoone isBookmarked: NO];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weatherCondition:(CDEntryWeatherCondition)weatherValue temperature:(CDEntryTemerature)temperatureValue isBookmarked:(BOOL)boolBookmarkedValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue date: dateValue dateCreated: dateCreatedValue body: stringBodyValue emotion: emotionValue weatherCondition: weatherValue temperature: temperatureValue isBookmarked: boolBookmarkedValue options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [[UniversalVariables globalVariables] DIARIES_returnFirstDiary], @"diary", nil]];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue emotion:(CDEntryEmotions)emotionValue weatherCondition:(CDEntryWeatherCondition)weatherValue temperature:(CDEntryTemerature)temperatureValue isBookmarked:(BOOL)boolBookmarkedValue options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringSubjectValue, dateValue, dateCreatedValue, stringBodyValue, [NSNumber numberWithInt: emotionValue], [NSNumber numberWithInt: weatherValue], [NSNumber numberWithInt: temperatureValue], [NSNumber numberWithBool: boolBookmarkedValue], dicIndex, nil];
    
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

- (CDEntryWeatherCondition)objectEntry_weatherCondition {
    return [[self objectAtIndex: ENTRIES_weatherCondition] intValue];
    
}

- (CDEntryTemerature)objectEntry_temperature {
    return [[self objectAtIndex: ENTRIES_temperature] intValue];
    
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

- (NSMutableDictionary *)ENTRIES_returnEntryOptionsForEntry:(NSArray *)arrayEntry {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary: [arrayEntry optionsDictionary]];
    
    NSLog( @"Table OK: +ENTRIES_returnEntryOptionsForEntry:");
    sqlite3_stmt *statement; const char *err;
    
    if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Diaries where id = %d;", [[[arrayEntry optionsDictionary] objectForKey: @"diaryID"] intValue]], &statement, &err)) {
        while (SQLStatementStep( statement)) {
            [dictionary setValue: SQLStatementRowIntoDiaryEntry( statement) forKey: @"diary"];
            [dictionary removeObjectForKey: @"diaryID"];
            
        }
        
    } else {
        sqlite3_close( [[UniversalVariables globalVariables] database]);
        NSAssert( 0, [NSString stringWithUTF8String: err]);
        
    }
    
    return dictionary;
    
}

@end

#pragma mark UniversalFunctions category (SQL_Entries_)

@implementation UniversalFunctions (SQL_Entries_)

+ (void)SQL_ENTRIES_voidInsertRowWithArray:(const NSArray *)arrayEntry {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLEntries]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES]; [dateFormatter setTimeZoneSeparator: 0];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Entries (subject, date, dateCreated, body, emotion, weatherCondition, temperature, isBookmarked, diaryID) values (\"%@\", \"%@\", \"%@\", \"%@\", %d, %d, %d, %d, %d);", [[arrayEntry objectEntry_subject] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[arrayEntry objectEntry_body] reformatForSQLQuries], [arrayEntry objectEntry_emotion], [arrayEntry objectEntry_weatherCondition], [arrayEntry objectEntry_temperature], [arrayEntry objectEntry_isBookmarked], [[[[[arrayEntry optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_ENTRIES_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_ENTRIES_voidInsertRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        [UniversalFunctions SQL_ENTRIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_ENTRIES_voidUpdateRowForArray:(const NSArray *)arrayEntry {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLEntries]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Entries SET subject = \"%@\", date = \"%@\", dateCreated = \"%@\", body = \"%@\", emotion = %d, weatherCondition = %d, temperature = %d, isBookmarked = %d, diaryID = %d where id = %d;", [[arrayEntry objectEntry_subject] reformatForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[arrayEntry objectEntry_body] reformatForSQLQuries], [arrayEntry objectEntry_emotion], [arrayEntry objectEntry_weatherCondition], [arrayEntry objectEntry_temperature], [arrayEntry objectEntry_isBookmarked], [[[[[arrayEntry optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] intValue], [[[arrayEntry optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Update row: +SQL_ENTRIES_voidUpdateRowForArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Updated row: %@: +SQL_ENTRIES_voidUpdateRowForArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        [UniversalFunctions SQL_ENTRIES_voidUpdateRowForArray: arrayEntry];
        
    }
    
}

+ (void)SQL_ENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLEntries]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Entries where id = %d;", [[[arrayEntry optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Delete row: +SQL_ENTRIES_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Deleted row: %@: +SQL_ENTRIES_voidDeleteRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLEntries];
        [UniversalFunctions SQL_ENTRIES_voidDeleteRowWithArray: arrayEntry];
        
    }
    
}

@end

#pragma mark - Outlines

#pragma mark NSArray category (ARRAY_OUTLINES__)

@implementation NSArray (ARRAY_OUTLINES__)

+ (id)arrayNEWOutline {
    return [NSMutableArray arrayNEWOutlineWithBody: @""];
    
}

+ (id)arrayNEWOutlineWithBody:(NSString *)stringBodyValue {
    return [NSMutableArray arrayNEWOutlineWithBody: stringBodyValue dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWOutlineWithBody:(NSString *)stringBodyValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWOutlineWithBody: stringBodyValue dateCreated: dateCreatedValue options: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWOutlineWithBody:(NSString *)stringBodyValue dateCreated:(NSDate *)dateCreatedValue options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringBodyValue, dateCreatedValue, dicIndex, nil];
    
}

- (NSString *)objectOutline_body {
    return [self objectAtIndex: OUTLINES_body];
    
}

- (NSDate *)objectOutline_dateCreated {
    return [self objectAtIndex: OUTLINES_dateCreated];
    
}


@end

#pragma mark UniversalVariables category (OUTLINES_)

@implementation UniversalVariables (OUTLINES_)

- (void)OUTLINES_writeNewForOutline:(NSArray *)arrayOutline {
    [UniversalFunctions SQL_OUTLINES_voidInsertRowWithArray: arrayOutline];
    
}

- (void)OUTLINES_updateForOutline:(NSArray *)arrayOutline {
    [UniversalFunctions SQL_OUTLINES_voidUpdateRowForArray: arrayOutline];
    
}

- (void)OUTLINES_deleteForOutline:(NSArray *)arrayOutline {
    [UniversalFunctions SQL_OUTLINES_voidDeleteRowWithArray: arrayOutline];
    
}

- (NSMutableDictionary *)OUTLINES_returnOutlineOptionsForOutline:(NSArray *)arrayOutine {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary: [arrayOutine optionsDictionary]];
    
    NSLog( @"Table OK: +OUTLINES_returnOutlineOptionsForOutline:");
    sqlite3_stmt *statement; const char *err;
    
    if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Entries where id = %d;", [[[arrayOutine optionsDictionary] objectForKey: @"entryID"] intValue]], &statement, &err)) {
        while (SQLStatementStep( statement)) {
            [dictionary setValue: SQLStatementRowIntoEntryEntry( statement) forKey: @"entry"];
            [dictionary removeObjectForKey: @"entryID"];
            
        }
        
    } else {
        sqlite3_close( [[UniversalVariables globalVariables] database]);
        NSAssert( 0, [NSString stringWithUTF8String: err]);
        
    }
    
    return dictionary;
    
}

@end

#pragma mark UniversalFunctions category (SQL_OUTLINES_)

@implementation UniversalFunctions (SQL_OUTLINES_)

/**
 * Inserts a row to the table Outlines
 * @param [in] arrayOutline: Outlines
 */
+ (void)SQL_OUTLINES_voidInsertRowWithArray:(const NSArray *)arrayOutline {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLOutilnes]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Outlines (body, dateCreated, entryID) values (\"%@\", \"%@\", %d);", [arrayOutline objectOutline_body], [dateFormatter stringFromDate: [arrayOutline objectOutline_dateCreated]], [[[[[arrayOutline optionsDictionary] objectForKey: @"entry"] optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_OUTLINES_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_OUTLINES_voidInsertRowWithArray:", arrayOutline);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLOutilnes];
        [UniversalFunctions SQL_OUTLINES_voidInsertRowWithArray: arrayOutline];
        
    }
    
}

/**
 * Updates an exisiting row to the table Outlines
 * @param [in] arrayOutline: Outlines
 */
+ (void)SQL_OUTLINES_voidUpdateRowForArray:(const NSArray *)arrayOutline {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLOutilnes]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Outlines SET body = \"%@\", dateCreated = \"%@\", entryID = %d where id = %d;", [arrayOutline objectOutline_body], [dateFormatter stringFromDate: [arrayOutline objectOutline_dateCreated]], [[[[[arrayOutline optionsDictionary] objectForKey: @"entry"] optionsDictionary] objectForKey: @"id"] intValue], [[[arrayOutline optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_OUTLINES_voidUpdateRowForArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_OUTLINES_voidUpdateRowForArray:", arrayOutline);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLOutilnes];
        [UniversalFunctions SQL_OUTLINES_voidUpdateRowForArray: arrayOutline];
        
    }
    
}

/**
 * Deletes a row to the table Outlines
 * @param [in] arrayOutline: Outlines
 */
+ (void)SQL_OUTLINES_voidDeleteRowWithArray:(const NSArray *)arrayOutline {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLOutilnes]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Outlines where id = %d;", [[[arrayOutline optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_OUTLINES_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_OUTLINES_voidDeleteRowWithArray:", arrayOutline);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLOutilnes];
        [UniversalFunctions SQL_OUTLINES_voidDeleteRowWithArray: arrayOutline];
        
    }
    
}


@end
