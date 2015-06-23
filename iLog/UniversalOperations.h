//
//  UniversalOperations.h
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISO8601DateFormatter.h"
#import <UIKit/UIKit.h>

static CGFloat CVTableViewCellDefaultCellHeight = 38;

@interface UniversalVariables : NSObject

+ (UniversalVariables *)globalVariables;

@end

@interface UniversalFunctions : NSObject

@end

#import <sqlite3.h>

typedef sqlite3 SQL3Database;
typedef sqlite3_stmt SQL3Statement;

/**
 * Used instead of sqlite3_exec(..);
 * @warning statement is compared to SQLITE_OK
 */
static inline BOOL SQLQueryMake( sqlite3 *database, NSString *sqlQuery, char **err) {
    NSLog( @"QUERY: %@", sqlQuery);
    return (sqlite3_exec( database, [sqlQuery UTF8String], NULL, NULL, &*err) == SQLITE_OK);
    
};
static inline BOOL SQLQueryMakeTrigger( sqlite3 *database, NSString *sqlStatement, NSString *sqlTriggerLogic, char **err) {
    if (sqlite3_exec( database, [sqlStatement UTF8String], NULL, NULL, &*err) == SQLITE_OK)
        if (sqlite3_exec( database, [@"BEGIN" UTF8String], NULL, NULL, &*err) == SQLITE_OK)
            if (sqlite3_exec( database, [sqlTriggerLogic UTF8String], NULL, NULL, &*err) == SQLITE_OK)
                if (sqlite3_exec( database, [@"END;" UTF8String], NULL, NULL, &*err) == SQLITE_OK)
                    return YES;
                else
                    return NO;
            else
                return NO;
        else
            return NO;
    else
        return NO;
    
};
/**
 * Used instead of sqlite3_prepare_v2(..);
 * @warning statement is compared to SQLITE_OK
 */
static inline BOOL SQLQueryPrepare( sqlite3 *database, NSString *sqlQuery, sqlite3_stmt **statement, const char **err) {
    NSLog( @"QUERY: %@", sqlQuery);
    return (sqlite3_prepare_v2( database, [sqlQuery UTF8String], -1, &*statement, &*err) == SQLITE_OK);
    
};
/**
 * Used instead of sqlite3_step(..) == SQLITE_ROW;
 * @warning statement is compared to SQLITE_ROW
 */
static inline BOOL SQLStatementStep( sqlite3_stmt *statement) {
    return (sqlite3_step( statement) == SQLITE_ROW);
    
};

typedef enum {
    CTSQLDiaries,
    CTSQLEntries,
    CTSQLStories,
    CTSQLStoryEntriesRelationship,
    CTSQLTags,
    CTSQLTagEntriesRelationship
    
} CDSQLTables;

@interface UniversalFunctions (SQL_)

/**
 * Creates the blank table if table does not exists
 */
+ (void)SQL_voidCreateTable:(CDSQLTables)table;
/**
 * Clears the table
 */
+ (void)SQL_voidClearRowsFromTable:(CDSQLTables)table;

/**
 * Checks if the file is loaded
 * @return BOOL
 */
+ (BOOL)SQL_returnStatusOfDatabase:(sqlite3 **)database;
/**
 * Checks if the table is created as well as the file
 * @return BOOL
 */
+ (BOOL)SQL_returnStatusOfTable:(CDSQLTables)table withDatabase:(sqlite3 **)database;
/**
 * Converts table into an array formatted according to table
 * @warning index dicitonary included
 * @warning "ORDER BY dateCreated DESC" included in certain tables
 * @return NSArray
 */
+ (NSArray *)SQL_returnContentsOfTable:(CDSQLTables)table;

@end

@interface UniversalOperations : NSObject

@end
