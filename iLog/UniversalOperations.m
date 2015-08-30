//
//  UniversalOperations.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UniversalOperations.h"

@implementation UniversalVariables
@synthesize database, viewController = view, currentView;

#pragma mark - Return Functions

+ (UniversalVariables *)globalVariables {
    static UniversalVariables *globalVariables = nil;
    if (!globalVariables)
        globalVariables = [UniversalVariables new];
    return globalVariables;
    
}

+ (NSString *)dataFilePathWithFileName:(NSString *)stringFileName extension:(NSString *)stringExtension {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dictionaryDocuments = [paths objectAtIndex: 0];
    return [dictionaryDocuments stringByAppendingPathComponent: [NSString stringWithFormat: @"%@.%@", stringFileName, stringExtension]];
    
}

- (id)init {
    if (!(self = [super init])) return nil;
    return self;
    
}

#pragma mark - Void's

- (UIViewController *)viewController {
    return view;
    
}

- (void)setViewController:(UIViewController *)viewControllerValue {
    [self setViewController: viewControllerValue asCurrentView: [[UniversalVariables globalVariables] currentView]];
    
}

- (void)setViewController:(UIViewController *)viewControllerValue asCurrentView:(UIViewController *)currentViewValue {
    [[UniversalVariables globalVariables] setCurrentView: currentViewValue];
    [[NSNotificationCenter defaultCenter] removeObserver: view name: kStatusBarTappedNotification object: nil];
    view = viewControllerValue;
    [[NSNotificationCenter defaultCenter] addObserver: view
                                             selector: @selector(statusBarTappedAction:)
                                                 name: kStatusBarTappedNotification
                                               object: nil];
    
}

#pragma mark - IBActions

#pragma mark - View Lifecycle

@end

@implementation UniversalFunctions

@end

NSString *SQLDatabase = @"database";

#import "DiaryController.h"

@implementation UniversalFunctions (SQL_)

+ (void)SQL_voidCreateTable:(CDSQLTables)table {
    [self SQL_returnStatusOfDatabase];
    char *err;
    NSString *sqlQuery = @"";
    switch (table) {
        case CTSQLDiaries:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Diaries (id INTEGER PRIMARY KEY UNIQUE, title TEXT, dateCreated TEXT, colorTrait INTEGER, isProtected INTEGER, passcode TEXT, maskTitle TEXT);";
            break;
        case CTSQLEntries:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Entries (id INTEGER PRIMARY KEY UNIQUE, diaryID INTEGER, subject TEXT, date TEXT, dateCreated TEXT, body TEXT, emotion INTEGER, weatherCondition INTEGER, temperature INTEGER, isBookmarked BOOLEAN, FOREIGN KEY (diaryID) REFERENCES Diaries(id) ON DELETE CASCADE);";
            break;
        case CTSQLOutilnes:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Outlines (id INTEGER PRIMARY KEY UNIQUE, entryID INTEGER, body TEXT, dateCreated TEXT, FOREIGN KEY (entryID) REFERENCES Entries(id) ON DELETE CASCADE);";
            break;
        case CTSQLStories:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Stories (id INTEGER PRIMARY KEY UNIQUE, diaryID INTEGER, title TEXT, dateCreated TEXT, description TEXT, colorTrait INTEGER, isProtected INTEGER, passcode TEXT, maskTitle TEXT, authenticationRequired INTEGER, FOREIGN KEY (diaryID) REFERENCES Diaries(id) ON DELETE CASCADE);";
            break;
        case CTSQLStoryEntriesRelationship:
            sqlQuery = @"CREATE TABLE StoryEntriesRelationship (id INTEGER PRIMARY KEY UNIQUE, storyID INTEGER, entryID INTEGER, FOREIGN KEY (storyID) REFERENCES Stories(id) ON DELETE CASCADE, FOREIGN KEY (entryID) REFERENCES Entries(id) ON DELETE CASCADE);";
            break;
        case CTSQLTagGroups:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS TagGroups (id INTEGER PRIMARY KEY UNIQUE, title TEXT, dateCreated TEXT);";
            break;
        case CTSQLTags:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS Tags (id INTEGER PRIMARY KEY UNIQUE, groupID INTEGER, title TEXT, dateCreated TEXT, FOREIGN KEY (groupID) REFERENCES TagGroups(id) ON DELETE CASCADE);";
            break;
        case CTSQLTagEntriesRelationship:
            sqlQuery = @"CREATE TABLE IF NOT EXISTS TagEntriesRelationship (id INTEGER PRIMARY KEY UNIQUE, tagID INTEGER, entryID INTEGER, FOREIGN KEY (tagID) REFERENCES Tags(id) ON DELETE CASCADE, FOREIGN KEY (entryID) REFERENCES Entries(id) ON DELETE CASCADE);";
            break;
            
    }
    if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlQuery, &err)) {
        sqlite3_close( [[UniversalVariables globalVariables] database]);
        NSLog( @"Table NOT CREATED: +SQL_voidCreateTable");
        NSAssert(0, [NSString stringWithUTF8String: err]);
        
    } else
        NSLog(  @"Table CREATED: +SQL_voidCreateTable");
    
}

+ (void)SQL_voidClearRowsFromTable:(CDSQLTables)table {
    if ([self SQL_returnStatusOfTable: table]) {
        char *err;
        NSString *sqlQuery = @"";
        switch (table) {
            case CTSQLDiaries:
                sqlQuery = @"DELETE FROM Diaries";
                break;
            case CTSQLEntries:
                sqlQuery = @"DELETE FROM Entries";
                break;
            case CTSQLOutilnes:
                sqlQuery = @"DELETE FROM Outlines";
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
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlQuery, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"Table NOT CLEARED: +SQL_voidClearRowsFromTable");
            NSAssert(0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Table CREATED: +SQL_voidClearRowsFromTable");
        
    } else {
        [self SQL_voidCreateTable: table];
        [self SQL_voidClearRowsFromTable: table];
        
    }
    
}

+ (BOOL)SQL_returnStatusOfDatabase {
    sqlite3 *sqlite3;
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex: 0] stringByAppendingPathComponent: SQLDatabase];
    if (sqlite3_open( [filePath UTF8String], &sqlite3) != SQLITE_OK) {
        sqlite3_close( sqlite3);
        NSLog( @"***Failed to Open: +SQL_returnStatusOfDatabase:");
        return NO;
        
    } else {
        NSLog( @"Opened: +SQL_returnStatusOfDatabase:");
        [[UniversalVariables globalVariables] setDatabase: sqlite3];
        return YES;
        
    }
    
}

+ (BOOL)SQL_returnStatusOfTable:(CDSQLTables)table {
    switch (table) {
        case CTSQLDiaries: case CTSQLEntries: case CTSQLOutilnes: case CTSQLStories: case CTSQLStoryEntriesRelationship: case CTSQLTagGroups: case CTSQLTags: case CTSQLTagEntriesRelationship: {
            BOOL status = [self SQL_returnStatusOfDatabase];
            SQL3Statement *statement; const char *err;
            NSString *stringFocusTableTitle = @"";
            switch (table) {
                case CTSQLDiaries:
                    stringFocusTableTitle = @"Diaries";
                    break;
                case CTSQLEntries:
                    stringFocusTableTitle = @"Entries";
                    break;
                case CTSQLStories:
                    stringFocusTableTitle = @"Stories";
                    break;
                case CTSQLStoryEntriesRelationship:
                    stringFocusTableTitle = @"StoryEntriesRelationship";
                    break;
                case CTSQLTagGroups:
                    stringFocusTableTitle = @"TagGroups";
                    break;
                case CTSQLTags:
                    stringFocusTableTitle = @"Tags";
                    break;
                case CTSQLTagEntriesRelationship:
                    stringFocusTableTitle = @"TagEntriesRelationship";
                    break;
                case CTSQLOutilnes:
                    stringFocusTableTitle = @"Outlines";
                    break;
                    
            } BOOL isFound = false;
            if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT name FROM sqlite_master WHERE type IN ('table','view') AND name NOT LIKE 'sqlite_%' UNION ALL SELECT name FROM sqlite_temp_master WHERE type IN ('table','view') ORDER BY 1;", &statement, &err)) {
                while (SQLStatementStep( statement)) {
                    if ([[NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, 0)] isEqualToString: stringFocusTableTitle]) {
                        isFound = true;
                        
                    }
                    
                }
                
            } else {
                status = NO;
                sqlite3_close( [[UniversalVariables globalVariables] database]);
                NSAssert( 0, [NSString stringWithUTF8String: err]);
                
            }
            
            return isFound; break;
            
        }
            
    }
    
}

+ (NSArray *)SQL_returnContentsOfTable:(CDSQLTables)table {
    if ([UniversalFunctions SQL_returnStatusOfTable: table]) {
        NSLog( @"Table OK: +SQL_returnContentsOfFile");
        sqlite3_stmt *statement; const char *err;
        NSMutableArray *arrayContents = [NSMutableArray array];
        switch (table) {
            case CTSQLDiaries: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM Diaries ORDER BY lower(title) ASC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array = SQLStatementRowIntoDiaryEntry( statement);
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                break;
                
            } case CTSQLEntries: {
                static ISO8601DateFormatter *dateFormatter = nil;
                if (!dateFormatter)
                    dateFormatter = [[ISO8601DateFormatter alloc] init];
                [dateFormatter setIncludeTime: YES];
                NSString *stringDate = [dateFormatter stringFromDate: [NSDate date]];
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Entries where strftime('%%m','%@') is strftime('%%m',date) AND strftime('%%d','%@') is strftime('%%d',date) AND strftime('%%Y','%@') is strftime('%%Y',date) ORDER BY date DESC;", stringDate, stringDate, stringDate], &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array =  SQLStatementRowIntoEntryEntry( statement);
                        [array updateOptionsDictionary: [[UniversalVariables globalVariables] ENTRIES_returnEntryOptionsForEntry: array]];
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                break;
                
            } case CTSQLStories: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM Stories ORDER BY id DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array =  SQLStatementRowIntoStoryEntry( statement);
                        [array updateOptionsDictionary: [[UniversalVariables globalVariables] STORIES_returnStoryOptionsForStory: array]];
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                break;
                
            } case CTSQLTagGroups: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM TagGroups ORDER BY id DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array =  SQLStatementRowIntoTagGroupEntry( statement);
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                break;
                
            } case CTSQLTags: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM Tags ORDER BY id DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array =  SQLStatementRowIntoTagEntry( statement);
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                break;
                
            } case CTSQLTagEntriesRelationship: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM TagEntriesRelationship ORDER BY id DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array =  SQLStatementRowIntoTagEntryRelationshipEntry( statement);
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                break;
                
            } case CTSQLOutilnes: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM Outlines ORDER BY id DESC;", &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        NSMutableArray *array =  SQLStatementRowIntoEntryEntry( statement);
                        [array updateOptionsDictionary: [[UniversalVariables globalVariables] ENTRIES_returnEntryOptionsForEntry: array]];
                        [arrayContents addObject: array];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
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

+ (NSArray *)SQL_returnRecordWithMaxIDOfTable:(CDSQLTables)table {
    int intIDValue = 0;
    NSMutableArray *array = [NSMutableArray array];
    if ([UniversalFunctions SQL_returnStatusOfTable: table]) {
        sqlite3_stmt *statement;
        const char *err;
        switch (table) {
            case CTSQLEntries: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT MAX(id) FROM Entries;", &statement, &err)) {
                    while (SQLStatementStep( statement))
                        intIDValue = sqlite3_column_int( statement, 0);
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Entries where id = %d;", intIDValue], &statement, &err)) {
                    while (SQLStatementStep( statement)) {
                        array = SQLStatementRowIntoEntryEntry( statement);
                        [array updateOptionsDictionary: [[UniversalVariables globalVariables] ENTRIES_returnEntryOptionsForEntry: array]];
                        
                    }
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
                }
                
                break;
                
            }
                
            default:
                break;
        }
        
    }
    
    return array;
    
}

+ (NSNumber *)SQL_returnNumberOfRowsInTable:(CDSQLTables)table {
    return [UniversalFunctions SQL_returnNumberOfRowsInTable: table withQuerySuffix: @""];
    
}

+ (NSNumber *)SQL_returnNumberOfRowsInTable:(CDSQLTables)table withQuerySuffix:(NSString *)sqlQuery {
    int intValue = 0;
    if ([UniversalFunctions SQL_returnStatusOfTable: table]) {
        sqlite3_stmt *statement;
        const char *err;
        switch (table) {
            case CTSQLDiaries: {
                if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [@"SELECT COUNT(*) FROM Diaries " stringByAppendingString: sqlQuery], &statement, &err)) {
                    while (SQLStatementStep( statement))
                        intValue = sqlite3_column_int( statement, 0);
                    
                } else {
                    sqlite3_close( [[UniversalVariables globalVariables] database]);
                    NSAssert( 0, [NSString stringWithUTF8String: err]);
                    
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
