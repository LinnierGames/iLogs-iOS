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

const NSUInteger DIARY_title = 0;
const NSUInteger DIARY_dateCreated = 1;

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

const int SQL_DIARY_id = 0;
const int SQL_DIARY_title = 1;
const int SQL_DIARY_dateCreated = 2;

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
            NSLog( @"***Failed to Add to Table: +SQL_ACTIVITY_voidInsertRowWithArray:");
            
        } else
            NSLog( @"Added to Table: %@: +SQL_ACTIVITY_voidInsertRowWithArray:", arrayEntry);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        [UniversalFunctions SQL_DIARIES_voidInsertRowWithArray: arrayEntry];
        
    }
    
}

+ (void)SQL_DIARIES_voidUpdateRowForArray:(const NSArray *)arrayEntry {
    
}

+ (void)SQL_DIARIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry {
    
}

@end
