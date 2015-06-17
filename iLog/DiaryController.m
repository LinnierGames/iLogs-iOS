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

- (NSDictionary *)index {
    return (NSDictionary *)[self lastObject];
    
}

@end

static const NSUInteger DIARY_title = 0;
static const NSUInteger DIARY_dateCreated = 1;

@implementation NSArray (ARRAY_Diaries_)

+ (id)arrayNEWDiary {
    return [NSMutableArray arrayNEWDiaryWithTitle: @"Untitled" dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWDiaryWithTitle: stringTitleValue dateCreated: dateCreatedValue index: @{}];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue index:(NSDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringTitleValue, dateCreatedValue, dicIndex, nil];
    
}

- (NSString *)objectDiary_title {
    return [self objectAtIndex: DIARY_title];
    
}

- (NSDate *)objectDiary_dateCreated {
    return [self objectAtIndex: DIARY_dateCreated];
    
}

@end

static const int SQL_DIARY_id = 0;
static const int SQL_DIARY_title = 1;
static const int SQL_DIARY_dateCreated = 2;

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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Diaries SET title = \"%@\", dateCreated = \"%@\");", [arrayEntry objectDiary_title], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]]];
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
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Diaries where id = %lu;", (unsigned long)[[[arrayEntry index] objectForKey: @"id"] integerValue]];
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


static const NSUInteger ENTRIES_subject = 0;
static const NSUInteger ENTRIES_body = 1;
static const NSUInteger ENTRIES_hasImage = 2;
static const NSUInteger ENTRIES_hasAudioMemo = 3;
static const NSUInteger ENTRIES_isBookmarked = 4;
static const NSUInteger ENTRIES_date = 5;
static const NSUInteger ENTRIES_dateCreated = 6;

@implementation NSArray (ARRAY_Entries_)

+ (id)arrayNEWEntry {
    return [NSMutableArray arrayNEWEntryWithSubject: @"" body: @""];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue body: stringBodyValue hasImage: NO hasAudioMemo: NO isBookmarked: NO date: [NSDate date] dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue isBookmarked:(BOOL)boolBookmarkedValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue body: stringBodyValue hasImage: boolImageValue hasAudioMemo: boolAudioMemoValue isBookmarked: boolBookmarkedValue date: dateValue dateCreated: dateCreatedValue index: @{}];
    
}

+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue hasImage:(BOOL)boolImageValue hasAudioMemo:(BOOL)boolAudioMemoValue isBookmarked:(BOOL)boolBookmarkedValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue index:(NSDictionary *)dicIndex {
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
    return [self objectAtIndex: ENTRIES_date];
    
}


@end

static const int SQL_ENTRIES_id = 0;
static const int SQL_ENTRIES_diaryID = 1;
static const int SQL_ENTRIES_subject = 2;
static const int SQL_ENTRIES_body = 3;
static const int SQL_ENTRIES_hasImage = 4;
static const int SQL_ENTRIES_hasAudioMemo = 5;
static const int SQL_ENTRIES_isBookmarked = 6;
static const int SQL_ENTRIES_date = 7;
static const int SQL_ENTRIES_dateCreated = 8;

@implementation UniversalFunctions (SQL_Entries_)

+ (void)SQL_ENTRIES_voidInsertRowWithArray:(const NSArray *)arrayEntry {
}

+ (void)SQL_ENTRIES_voidUpdateRowForArray:(const NSArray *)arrayEntry {
}

+ (void)SQL_ENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry {
}

@end
