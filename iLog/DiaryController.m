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

@implementation NSArray (ARRAY_)

- (NSMutableDictionary *)options {
    return (NSMutableDictionary *)[self lastObject];
    
}

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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Diaries (title, dateCreated) values (\"%@\", \"%@\");", [arrayEntry objectDiary_title], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]]];
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Diaries SET title = \"%@\", dateCreated = \"%@\" where id = %lu;", [arrayEntry objectDiary_title], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]], [[[arrayEntry options] objectForKey: @"id"] unsignedLongValue]];
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
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue body: stringBodyValue hasImage: NO hasAudioMemo: NO isBookmarked: NO date: [NSDate date] dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue isBookmarked:(BOOL)boolBookmarkedValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue body: stringBodyValue hasImage: boolImageValue hasAudioMemo: boolAudioMemoValue isBookmarked: boolBookmarkedValue date: dateValue dateCreated: dateCreatedValue index: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue isBookmarked:(BOOL)boolBookmarkedValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue index:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringSubjectValue, stringBodyValue, [NSNumber numberWithBool: boolImageValue], [NSNumber numberWithBool: boolAudioMemoValue], [NSNumber numberWithBool: boolBookmarkedValue], dateValue, dateCreatedValue, dicIndex, nil];
    
}

- (NSString *)objectEntry_subject {
    return [self objectAtIndex: ENTRIES_subject];
    
}

- (NSString *)objectEntry_body {
    return [self objectAtIndex: ENTRIES_body];
    
}

- (BOOL)objectEntry_hasImage {
    return [[self objectAtIndex: ENTRIES_hasImage] boolValue];
    
}

- (BOOL)objectEntry_hasAudioMemo {
    return [[self objectAtIndex: ENTRIES_hasAudioMemo] boolValue];
    
}

- (BOOL)objectEntry_isBookmarked {
    return [[self objectAtIndex: ENTRIES_isBookmarked] boolValue];
    
}

- (NSDate *)objectEntry_date {
    return [self objectAtIndex: ENTRIES_date];
    
}

- (NSDate *)objectEntry_dateCreated {
    return [self objectAtIndex: ENTRIES_dateCreated];
    
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Entries (subject, body, hasImage, hasAudioMemo, isBookmarked, date, dateCreated, diaryID) values (\"%@\", \"%@\", %d, %d, %d, \"%@\", \"%@\", %lu);", [arrayEntry objectEntry_subject], [arrayEntry objectEntry_body], [arrayEntry objectEntry_hasImage], [arrayEntry objectEntry_hasAudioMemo], [arrayEntry objectEntry_isBookmarked], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[[arrayEntry options] objectForKey: @"diaryID"] unsignedLongValue]];
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Entires SET subject = \"%@\", body = \"%@\", hasImage = %d, hasAudioMemo = %d, isBookmarked = %d, date = \"%@\" dateCreated = \"%@\", diaryID = %lu;", [arrayEntry objectEntry_subject], [arrayEntry objectEntry_body], [arrayEntry objectEntry_hasImage], [arrayEntry objectEntry_hasAudioMemo], [arrayEntry objectEntry_isBookmarked], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]], [[[arrayEntry options] objectForKey: @"diaryID"] unsignedLongValue]];
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
