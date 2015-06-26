//
//  UniversalOperations.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UniversalOperations.h"

@implementation UniversalVariables

+ (UniversalVariables *)globalVariables {
    static UniversalVariables *globalVariables = nil;
    if (!globalVariables)
        globalVariables = [UniversalVariables new];
    return globalVariables;
    
}

- (id)init {
    if (!(self = [super init])) return nil;
    return self;
    
}

@end

@implementation UniversalFunctions

@end

NSString *SQLDatabase = @"database";

#import "DiaryController.h"

@implementation UniversalFunctions (SQL_)

+ (void)SQL_voidCreateTable:(CDSQLTables)table {
    sqlite3 *database;
    [self SQL_returnStatusOfDatabase: &database];
    char *err;
    NSString *sqlQuery = @"";
    switch (table) {
        case CTSQLDiaries:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Diaries (id INTEGER PRIMARY KEY UNIQUE, title TEXT, dateCreated TEXT);";
            break;
        case CTSQLEntries:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Entries (id INTEGER PRIMARY KEY UNIQUE, diaryID INTEGER, subject TEXT, date TEXT, dateCreated TEXT, body TEXT, emotion INTEGER, weatherCondition INTEGER, temperature INTEGER, isBookmarked BOOLEAN, FOREIGN KEY (diaryID) REFERENCES Diaries(id) ON DELETE CASCADE);";
            break;
        case CTSQLStories:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Stories (id INTEGER PRIMARY KEY UNIQUE, title TEXT, description TEXT);";
            break;
        case CTSQLStoryEntriesRelationship:
            sqlQuery = @"CREATE TABLE StoryEntriesRelationship (id INTEGER PRIMARY KEY UNIQUE, storyID INTEGER, entryID INTEGER, FOREIGN KEY (storyID) REFERENCES Stories(id) ON DELETE CASCADE, FOREIGN KEY (entryID) REFERENCES Entries(id) ON DELETE CASCADE);";
            break;
        case CTSQLTags:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Tags (id INTEGER PRIMARY KEY UNIQUE, title TEXT);";
            break;
        case CTSQLTagEntriesRelationship:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS TagEntriesRelationship (id INTEGER PRIMARY KEY UNIQUE, tagID INTEGER, entryID INTEGER, FOREIGN KEY (tagID) REFERENCES Tags(id) ON DELETE CASCADE, FOREIGN KEY (entryID) REFERENCES Entries(id) ON DELETE CASCADE);";
            break;
            
    }
    if (!SQLQueryMake( database, sqlQuery, &err)) {
        NSAssert(0, [NSString stringWithUTF8String: err]);
        sqlite3_close( database);
        NSLog( @"Table NOT CREATED: +SQL_voidCreateTable");
        
    } else
        NSLog(  @"Table CREATED: +SQL_voidCreateTable");
    
}

+ (void)SQL_voidClearRowsFromTable:(CDSQLTables)table {
    sqlite3 *database;
    if ([self SQL_returnStatusOfTable: table withDatabase: &database]) {
        char *err;
        NSString *sqlQuery = @"";
        switch (table) {
            case CTSQLDiaries:
                sqlQuery = @"DELETE FROM Diaries";
                break;
            case CTSQLEntries:
                sqlQuery = @"DELETE FROM Entries";
                break;
            case CTSQLStories:
                sqlQuery = @"DELETE FROM Stories";
                break;
            case CTSQLTags:
                sqlQuery = @"DELETE FROM Tags";
                break;
                
            default:
                NSAssert(table != CTSQLStoryEntriesRelationship || table != CTSQLTagEntriesRelationship, @"Cannont clear a relationship table");
                break;
        }
        if (!SQLQueryMake( database, sqlQuery, &err)) {
            NSAssert(0, [NSString stringWithUTF8String: err]);
            sqlite3_close( database);
            NSLog( @"Table NOT CLEARED: +SQL_voidClearRowsFromTable");
            
        } else
            NSLog( @"Table CREATED: +SQL_voidClearRowsFromTable");
        
    } else {
        [self SQL_voidCreateTable: table];
        [self SQL_voidClearRowsFromTable: table];
        
    }
    
}

+ (BOOL)SQL_returnStatusOfDatabase:(sqlite3 **)database {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex: 0] stringByAppendingPathComponent: SQLDatabase];
    if (sqlite3_open( [filePath UTF8String], &*database) != SQLITE_OK) {
        sqlite3_close( *database);
        NSLog( @"***Failed to Open: +SQL_returnStatusOfTable:withDatabase:");
        return NO;
        
    } else {
        NSLog( @"Opened: +SQL_returnStatusOfTable:withDatabase:");
        return YES;
        
    }
    
}

+ (BOOL)SQL_returnStatusOfTable:(CDSQLTables)table withDatabase:(sqlite3 **)database {
    switch (table) {
        case CTSQLDiaries: case CTSQLEntries: case CTSQLStories: case CTSQLStoryEntriesRelationship: case CTSQLTags: case CTSQLTagEntriesRelationship: {
            BOOL status = [self SQL_returnStatusOfDatabase: database];
            SQL3Statement *statement; const char *err;
            
            [UniversalFunctions SQL_voidCreateTable: table];
            
            return YES;
            
            if (SQLQueryPrepare( *database, @"create database lol;", &statement, &err)) {
                while (SQLStatementStep( statement)) {
                    NSLog( @"%@", [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, 0)]);
                    
                }
                
            } else {
                status = NO;
                NSAssert( 0, [NSString stringWithUTF8String: err]);
                
            }
            
            return status; break;
            
        }
            
    }
    
}

+ (NSArray *)SQL_returnContentsOfTable:(CDSQLTables)table {
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: table withDatabase: &database]) {
        NSLog( @"Table OK: +SQL_returnContentsOfFile");
        sqlite3_stmt *statement; const char *err;
        NSMutableArray *arrayContents = [NSMutableArray array];
        switch (table) {
            case CTSQLDiaries: {
                if (SQLQueryPrepare( database, @"SELECT * FROM Diaries ORDER BY title DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array = SQLStatementRowIntoDiaryEntry( statement);
                        [arrayContents addObject: array];
                        
                    }
                    
                } else
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                break;
                
            } case CTSQLEntries: {
                if (SQLQueryPrepare( database, @"SELECT * FROM Entries ORDER BY date DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement))
                        [arrayContents addObject: SQLStatementRowIntoEntryEntry( statement)];
                    
                } else
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                break;
                
            }
                
            default:
                break;
        }
        
        return [NSArray arrayWithArray: arrayContents];
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: table];
        return [UniversalFunctions SQL_returnContentsOfTable: table];
        
    }
    
}

+ (NSNumber *)SQL_returnNumberOfRowsInTable:(CDSQLTables)table {
    return [UniversalFunctions SQL_returnNumberOfRowsInTable: table withQuerySuffix: @""];
    
}

+ (NSNumber *)SQL_returnNumberOfRowsInTable:(CDSQLTables)table withQuerySuffix:(NSString *)sqlQuery {
    int intValue = 0;
    sqlite3 *database;
    if ([UniversalFunctions SQL_returnStatusOfTable: table withDatabase: &database]) {
        sqlite3_stmt *statement;
        const char *err;
        switch (table) {
            case CTSQLDiaries: {
                if (SQLQueryPrepare( database, [@"SELECT COUNT(*) FROM Diaries " stringByAppendingString: sqlQuery], &statement, &err)) {
                    while (SQLStatementStep( statement))
                        intValue = sqlite3_column_int( statement, 0);
                    
                }
                break;
                
            }
                
            default:
                break;
        }
        
    }
    
    return [NSNumber numberWithInt: intValue];
    
}


@end

@implementation UniversalOperations

@end
