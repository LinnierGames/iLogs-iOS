//
//  UniversalOperations.h
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

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
static inline BOOL SQLQueryMake( sqlite3 *database, NSString *sqlStatement, char **err) {
    return (sqlite3_exec( database, [sqlStatement UTF8String], NULL, NULL, &*err) == SQLITE_OK);
    
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

@interface UniversalFunctions (SQL_)

@end

@interface UniversalOperations : NSObject

@end
