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
    return [NSMutableArray arrayNEWDiaryWithTitle: @"Untitled"];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue {
    return [NSMutableArray arrayNEWDiaryWithTitle: stringTitleValue dateCreated: [NSDate date] colorTrait: CTColorNormal isProtected: NO passcode: @"" maskTitle: @"Locked Diary"];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue {
    return [NSMutableArray arrayNEWDiaryWithTitle: stringTitleValue dateCreated: dateCreatedValue colorTrait: colorTraitValue isProtected: boolProtectedValue passcode: stringPasscodeValue maskTitle: stringMaskTitleValue index: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue index:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringTitleValue, dateCreatedValue, [NSNumber numberWithInt: colorTraitValue], [NSNumber numberWithBool: boolProtectedValue], stringPasscodeValue, stringMaskTitleValue, dicIndex, nil];
    
}

- (NSString *)objectDiary_title {
    return [self objectAtIndex: DIARY_title];
    
}

- (NSDate *)objectDiary_dateCreated {
    return [self objectAtIndex: DIARY_dateCreated];
    
}

- (CDColorTraits)objectDiary_colorTrait {
    return [[self objectAtIndex: DIARY_colorTrait] intValue];
    
}

- (BOOL)objectDiary_isProtected {
    return [[self objectAtIndex: DIARY_isProtected] boolValue];
    
}

- (NSString *)objectDiary_passcode {
    return [self objectAtIndex: DIARY_passcode];
    
}

- (NSString *)objectDiary_maskTitle {
    return [self objectAtIndex: DIARY_maskTitle];
    
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Diaries (title, dateCreated, colorTrait, isProtected, passcode, maskTitle) values (\"%@\", \"%@\", %d, %d, \"%@\", \"%@\");", [[arrayEntry objectDiary_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]], [arrayEntry objectDiary_colorTrait], [arrayEntry objectDiary_isProtected], [arrayEntry objectDiary_passcode], [arrayEntry objectDiary_maskTitle]];
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Diaries SET title = \"%@\", dateCreated = \"%@\", colorTrait = %d, isProtected = %d, passcode = \"%@\", maskTitle = \"%@\" where id = %u;", [[arrayEntry objectDiary_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectDiary_dateCreated]], [arrayEntry objectDiary_colorTrait], [arrayEntry objectDiary_isProtected], [arrayEntry objectDiary_passcode], [arrayEntry objectDiary_maskTitle], [[[arrayEntry optionsDictionary] objectForKey: @"id"] unsignedIntValue]];
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
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Diaries where id = %u;", [[[arrayEntry optionsDictionary] objectForKey: @"id"] unsignedIntValue]];
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
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries]) {
        NSLog( @"Table OK: +DIARIES_returnFirstDiary:");
        sqlite3_stmt *statement; const char *err; NSArray *array = [NSArray array];
        
        if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], @"SELECT * FROM Diaries ORDER BY title LIMIT 1;", &statement, &err)) {
            while (SQLStatementStep( statement)) {
                array = [NSArray arrayWithArray: SQLStatementRowIntoDiaryEntry( statement)];
                
            }
            
        } else {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        }
        
        return array;
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
        return [[UniversalVariables globalVariables] DIARIES_returnFirstDiary];
        
    }
    
}

- (NSMutableDictionary *)DIARIES_returnDiaryOptionsForDiary:(NSArray *)arrayDiary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary: [arrayDiary optionsDictionary]];
    
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLDiaries]) {
        NSLog( @"Table OK: +DIARIES_returnEntriesOptionsForDiary:");
        sqlite3_stmt *statement; const char *err;
        
        if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Entries where diaryID = %u", [[[arrayDiary optionsDictionary] objectForKey: @"id"] unsignedIntValue]], &statement, &err)) {
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
        [UniversalFunctions SQL_voidCreateTable: CTSQLDiaries];
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
    return [NSMutableArray arrayNEWEntryWithSubject: stringSubjectValue date: dateValue dateCreated: dateCreatedValue body: stringBodyValue emotion: emotionValue weatherCondition: weatherValue temperature: temperatureValue isBookmarked: boolBookmarkedValue options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [[UniversalVariables globalVariables] DIARIES_returnFirstDiary], @"diary", [NSMutableArray array], @"tags", nil]];
    
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
    [dictionary setObject: [NSMutableArray array] forKey: @"tags"];
    
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Entries (subject, date, dateCreated, body, emotion, weatherCondition, temperature, isBookmarked, diaryID) values (\"%@\", \"%@\", \"%@\", \"%@\", %d, %d, %d, %d, %d);", [[arrayEntry objectEntry_subject] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[arrayEntry objectEntry_body] stringByReformatingForSQLQuries], [arrayEntry objectEntry_emotion], [arrayEntry objectEntry_weatherCondition], [arrayEntry objectEntry_temperature], [arrayEntry objectEntry_isBookmarked], [[[[[arrayEntry optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] intValue]];
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
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Entries SET subject = \"%@\", date = \"%@\", dateCreated = \"%@\", body = \"%@\", emotion = %d, weatherCondition = %d, temperature = %d, isBookmarked = %d, diaryID = %d where id = %d;", [[arrayEntry objectEntry_subject] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayEntry objectEntry_date]], [dateFormatter stringFromDate: [arrayEntry objectEntry_dateCreated]], [[arrayEntry objectEntry_body] stringByReformatingForSQLQuries], [arrayEntry objectEntry_emotion], [arrayEntry objectEntry_weatherCondition], [arrayEntry objectEntry_temperature], [arrayEntry objectEntry_isBookmarked], [[[[[arrayEntry optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] intValue], [[[arrayEntry optionsDictionary] objectForKey: @"id"] intValue]];
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

#pragma mark NSDate category (COLOR_)

// macro to convert hex value to UIColor
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation NSDate (COLOR_)

- (UIColor *)colorBetween:(UIColor *)colorA and:(UIColor *)colorB distance:(CGFloat)pct {
    CGFloat aR, aG, aB, aA;
    [colorA getRed:&aR green:&aG blue:&aB alpha:&aA];
    
    CGFloat bR, bG, bB, bA;
    [colorB getRed:&bR green:&bG blue:&bB alpha:&bA];
    
    CGFloat rR = (1.0-pct)*aR + pct*bR;
    CGFloat rG = (1.0-pct)*aG + pct*bG;
    CGFloat rB = (1.0-pct)*aB + pct*bB;
    CGFloat rA = (1.0-pct)*aA + pct*bA;
    
    return [UIColor colorWithRed:rR green:rG blue:rB alpha:rA];
}

- (NSInteger)minutesSinceMidnightOfDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSIntegerMax fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *midnight = [[NSCalendar currentCalendar] dateFromComponents: components];
    
    NSDateComponents *diff = [[NSCalendar currentCalendar] components: NSCalendarUnitMinute fromDate: midnight toDate: date options:0];
    
    return [diff minute];
    
}

- (UIColor *)dayNightColorByTimeOfDay {
    static int COLOR_distanceValue = 0;
    static int COLOR_color = 1;
    
    static NSTimeInterval NSHourInterval24 = 60;
    
    // look up the bounds of interpolation here
    
    //Good for Default: Summer
    NSArray *wheelDefault5int = @[
                       @[ @(0), UIColorFromRGB(0x4A90E2) ],
                       @[ @(5*NSHourInterval24), UIColorFromRGB(0xFBF3B7) ],
                       @[ @(12*NSHourInterval24), UIColorFromRGB(0xFABB78) ],
                       @[ @(15*NSHourInterval24), UIColorFromRGB(0xCE6F2D) ],
                       @[ @(20*NSHourInterval24), UIColorFromRGB(0x92B1F4) ],
                       @[ @(24*NSHourInterval24), UIColorFromRGB(0x4A90E2) ]];
    
    NSArray *wheel = @[@[ @(0), UIColorFromRGB(0x4A90E2) ],
                       @[ @(4*NSHourInterval24), UIColorFromRGB(0xFBF3B7) ],
                       @[ @(8*NSHourInterval24), UIColorFromRGB(0xFABB78) ],
                       @[ @(12*NSHourInterval24), UIColorFromRGB(0xFF9E5B) ],
                       @[ @(16*NSHourInterval24), UIColorFromRGB(0xE17123) ],
                       @[ @(20*NSHourInterval24), UIColorFromRGB(0x92B1F4) ],
                       @[ @(24*NSHourInterval24), UIColorFromRGB(0x0064D9) ]];
    
    NSInteger m = [self minutesSinceMidnightOfDate: self];
    
    // find the index in wheel where the minute bound exceeds our date's minutes (m)
    NSInteger wheelIndex = 0;
    for (NSArray *pair in wheel) {
        NSInteger timePosition = [pair[COLOR_distanceValue] intValue];
        if (m < timePosition) {
            break;
        }
        wheelIndex++;
    }
    
    // wheelIndex will always be in 1..4, get the pair of bounds at wheelIndex
    // and the preceding pair (-1).
    NSArray *priorPair = wheel[wheelIndex-1];
    NSArray *pair = wheel[wheelIndex];
    
    CGFloat priorMinutes = [priorPair[COLOR_distanceValue] intValue];
    CGFloat minutes = [pair[COLOR_distanceValue] intValue];
    
    // this is how far we are between the bounds pairs
    CGFloat minutesPct = ((float)m - priorMinutes) / (minutes - priorMinutes);
    
    // and the colors for the bounds pair
    UIColor *priorColor = priorPair[COLOR_color];
    UIColor *color = pair[COLOR_color];
    
    // call the color interpolation
    return [self colorBetween: priorColor and: color distance: minutesPct];
    
}

@end

#pragma mark - Stories

#pragma mark NSArray category (ARRAY_STORIES_)

@implementation NSArray (ARRAY_STORIES_)

+ (id)arrayNEWStory {
    return [NSMutableArray arrayNEWStoryWithTitle: @"Untitled" description: @""];
    
}

+ (id)arrayNEWStoryWithTitle:(NSString *)stringTitleValue description:(NSString *)stringDescriptionValue {
    return [NSMutableArray arrayNEWStoryWithTitle: stringTitleValue dateCreated: [NSDate date] description: stringDescriptionValue colorTrait: CTColorNormal isProtected: NO passcode: @"" maskTitle: @"Locked Story" authenticationRequired: NO];
    
}

+ (id)arrayNEWStoryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue description:(NSString *)stringDescriptionValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolIsProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue authenticationRequired:(BOOL)boolAuthenRequired {
    return [NSMutableArray arrayNEWStoryWithTitle: stringTitleValue dateCreated: dateCreatedValue description: stringDescriptionValue colorTrait: colorTraitValue isProtected: boolIsProtectedValue passcode: stringPasscodeValue maskTitle: stringMaskTitleValue authenticationRequired: boolAuthenRequired options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [[UniversalVariables globalVariables] DIARIES_returnFirstDiary], @"diary", nil]];
    
}

+ (id)arrayNEWStoryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue description:(NSString *)stringDescriptionValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolIsProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue authenticationRequired:(BOOL)boolAuthenRequired options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringTitleValue, dateCreatedValue, stringDescriptionValue, [NSNumber numberWithInt: colorTraitValue], [NSNumber numberWithBool: boolIsProtectedValue], stringPasscodeValue, stringMaskTitleValue, [NSNumber numberWithBool: boolAuthenRequired], dicIndex, nil];
    
}

- (NSString *)objectStory_title {
    return [self objectAtIndex: STORIES_title];
    
}

- (NSDate *)objectStory_dateCreated {
    return [self objectAtIndex: STORIES_dateCreated];
    
}

- (NSString *)objectStory_description {
    return [self objectAtIndex: STORIES_description];
    
}

- (CDColorTraits)objectStory_colorTrait {
    return [[self objectAtIndex: STORIES_colorTrait] intValue];
    
}

- (BOOL)objectStory_isProtected {
    return [[self objectAtIndex: STORIES_isProtected] boolValue];
    
}

- (NSString *)objectStory_passcode {
    return [self objectAtIndex: STORIES_passcode];
    
}

- (NSString *)objectStory_maskTitle {
    return [self objectAtIndex: STORIES_maskTitle];
    
}

- (BOOL)objectStory_authenticationRequired {
    return [[self objectAtIndex: STORIES_authenticationRequired] boolValue];
    
}


@end

#pragma mark UniversalVariables category (STORIES_)

@implementation UniversalVariables (STORIES_)

- (void)STORIES_writeNewForStory:(NSArray *)arrayStory {
    [UniversalFunctions SQL_STORIES_voidInsertRowWithArray: arrayStory];
    
}

- (void)STORIES_updateForStory:(NSArray *)arrayStory {
    [UniversalFunctions SQL_STORIES_voidUpdateRowWithArray: arrayStory];
    
}

- (void)STORIES_deleteForStory:(NSArray *)arrayStory {
    [UniversalFunctions SQL_STORIES_voidDeleteRowWithArray: arrayStory];
    
}

- (NSMutableDictionary *)STORIES_returnStoryOptionsForStory:(NSArray *)arrayStory {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary: [arrayStory optionsDictionary]];
    
    NSLog( @"Table OK: +ENTRIES_returnEntryOptionsForEntry:");
    sqlite3_stmt *statement; const char *err;
    
    if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Diaries where id = %d;", [[[arrayStory optionsDictionary] objectForKey: @"diaryID"] intValue]], &statement, &err)) {
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

#pragma mark UniversalFunctions category (SQL_STORIES_)

@implementation UniversalFunctions (SQL_STORIES_)

+ (void)SQL_STORIES_voidInsertRowWithArray:(const NSArray *)arrayStory {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLStories]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Stories (title, dateCreated, description, colorTrait, isProtected, passcode, maskTitle, authenticationRequired, diaryID) values (\"%@\", \"%@\", \"%@\", %d, %d, \"%@\", \"%@\", %d, %d);", [[arrayStory objectStory_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayStory objectStory_dateCreated]], [[arrayStory objectStory_description] stringByReformatingForSQLQuries], [arrayStory objectStory_colorTrait], [arrayStory objectStory_isProtected], [arrayStory objectStory_passcode], [arrayStory objectStory_maskTitle], [arrayStory objectStory_authenticationRequired], [[[[[arrayStory optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_STORIES_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_STORIES_voidInsertRowWithArray:", arrayStory);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLStories];
        [UniversalFunctions SQL_STORIES_voidInsertRowWithArray: arrayStory];
        
    }
    
}

+ (void)SQL_STORIES_voidUpdateRowWithArray:(const NSArray *)arrayStory {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLStories]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Stories SET title = \"%@\", dateCreated = \"%@\", description = \"%@\", colorTrait = %d, isProtected = %d, passcode = \"%@\", maskTitle = \"%@\", authenticationRequired = %d, diaryId = %d where id = %d;", [[arrayStory objectStory_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayStory objectStory_dateCreated]], [[arrayStory objectStory_description] stringByReformatingForSQLQuries], [arrayStory objectStory_colorTrait], [arrayStory objectStory_isProtected], [arrayStory objectStory_passcode], [arrayStory objectStory_maskTitle], [arrayStory objectStory_authenticationRequired], [[[[[arrayStory optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] intValue], [[[arrayStory optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_STORIES_voidUpdateRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_STORIES_voidUpdateRowWithArray:", arrayStory);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLStories];
        [UniversalFunctions SQL_STORIES_voidUpdateRowWithArray: arrayStory];
        
    }
    
}

+ (void)SQL_STORIES_voidDeleteRowWithArray:(const NSArray *)arrayStory {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLStories]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Stories where id = %d;", [[[arrayStory optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_STORIES_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_STORIES_voidDeleteRowWithArray:", arrayStory);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLStories];
        [UniversalFunctions SQL_STORIES_voidDeleteRowWithArray: arrayStory];
        
    }
    
}

@end

#pragma mark UniversalFunctions category (STORIES_)

@implementation UniversalFunctions (STORIES_)

+ (NSArray *)STORIES_returnGroupedStories {
    return [UniversalFunctions STORIES_returnGroupedStoriesWithStories: [UniversalFunctions SQL_returnContentsOfTable: CTSQLStories]];
    
}

+ (NSArray *)STORIES_returnGroupedStoriesWithStories:(const NSArray *)arrayStories {
    NSMutableArray *arrayGroupedStories = [NSMutableArray array];
    
    for (NSArray *arrayStory in arrayStories) {
        if ([arrayGroupedStories count] > 0) {
            BOOL isFound = false;
            for (int index = 0; index < [arrayGroupedStories count]; index += 1) {
                if ([[[[[[arrayGroupedStories objectAtIndex: index] lastObject] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"] isEqualToNumber: [[[[arrayStory optionsDictionary] objectForKey: @"diary"] optionsDictionary] objectForKey: @"id"]]) {
                    [[arrayGroupedStories objectAtIndex: index] insertObject: arrayStory atIndex: 0];
                    isFound = true;
                    break;
                    
                }
                
            }
            if (!isFound)
                [arrayGroupedStories addObject: [NSMutableArray arrayWithObjects: arrayStory, @{@"diary": [[arrayStory optionsDictionary] objectForKey: @"diary"]}, nil]];
            
        } else
            [arrayGroupedStories addObject: [NSMutableArray arrayWithObjects: arrayStory, @{@"diary": [[arrayStory optionsDictionary] objectForKey: @"diary"]}, nil]];
        
    }
    
    //Sort Stores within each Group
    for (NSMutableArray *arrayGroup in arrayGroupedStories) {
        [arrayGroup sortUsingComparator: ^NSComparisonResult(id a, id b) {
            
            if ([a isKindOfClass: [NSArray class]] && [b isKindOfClass: [NSArray class]]) {
                NSString *stringA = [[a objectStory_title] lowercaseString];
                NSString *stringB = [[b objectStory_title] lowercaseString];
                
                return [stringA compare: stringB];
                
            } else
                return NSOrderedSame;
            
        }];
        
    }
    
    //Sort Grouped Stories by the Diary Title
    [arrayGroupedStories sortUsingComparator: ^NSComparisonResult(id a, id b) {
        NSString *stringA = [[[[a lastObject] objectForKey: @"diary"] objectDiary_title] lowercaseString];
        NSString *stringB = [[[[b lastObject] objectForKey: @"diary"] objectDiary_title] lowercaseString];
        
        return [stringA compare: stringB];
        
    }];
    
    return arrayGroupedStories;
    
}

@end

#pragma mark - Tag Groups

#pragma mark NSArray category (ARRAY_TAGGROUPS_)

@implementation NSArray (ARRAY_TAGGROUPS_)

+ (id)arrayNEWTagGroup {
    return [NSMutableArray arrayNEWTagWithTitle: @"Untitled"];
    
}

+ (id)arrayNEWTagGroupWithTitle:(NSString *)stringTitleValue {
    return [NSMutableArray arrayNEWTagWithTitle: stringTitleValue dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWTagGroupWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWTagWithTitle: stringTitleValue dateCreated: dateCreatedValue options: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWTagGroupWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringTitleValue, dateCreatedValue, dicIndex, nil];
    
}

- (NSString *)objectTagGroup_title {
    return [self objectAtIndex: TAGGROUPS_title];
    
}

- (NSDate *)objectTagGroup_dateCreated {
    return [self objectAtIndex: TAGGROUPS_dateCreated];
    
}


@end

#pragma mark UniversalVariables category (TAGGROUPS_)

@implementation UniversalVariables (TAGGROUPS_)

- (void)TAGGROUPS_writeNewForTagGroup:(NSArray *)arrayTagGroup {
    [UniversalFunctions SQL_TAGGROUPS_voidInsertRowWithArray: arrayTagGroup];
    
}

- (void)TAGGROUPS_updateForTagGroup:(NSArray *)arrayTagGroup {
    [UniversalFunctions SQL_TAGGROUPS_voidUpdateRowWithArray: arrayTagGroup];
    
}

- (void)TAGGROUPS_deleteForTagGroup:(NSArray *)arrayTagGroup {
    [UniversalFunctions SQL_TAGS_voidAssignTagsToUngrouppedTagsForTagGroupID: [[[arrayTagGroup optionsDictionary] objectForKey: @"id"] unsignedIntegerValue]];
    [UniversalFunctions SQL_TAGGROUPS_voidDeleteRowWithArray: arrayTagGroup];
    
}

@end

#pragma mark UniversalFunctions category (SQL_TAGGROUPS_)

@implementation UniversalFunctions (SQL_TAGGROUPS_)

+ (void)SQL_TAGGROUPS_voidInsertRowWithArray:(const NSArray *)arrayTagGroup {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTagGroups]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO TagGroups (title, dateCreated) values (\"%@\", \"%@\");", [[arrayTagGroup objectTagGroup_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayTagGroup objectTagGroup_dateCreated]]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGGROUPS_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGGROUPS_voidInsertRowWithArray:", arrayTagGroup);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTagGroups];
        [UniversalFunctions SQL_TAGGROUPS_voidInsertRowWithArray: arrayTagGroup];
        
    }
    
}

+ (void)SQL_TAGGROUPS_voidUpdateRowWithArray:(const NSArray *)arrayTagGroup {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTagGroups]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE TagGroups SET title = \"%@\", dateCreated = \"%@\" where id = %d;", [[arrayTagGroup objectTagGroup_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayTagGroup objectTagGroup_dateCreated]], [[[arrayTagGroup optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGGROUPS_voidUpdateRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGGROUPS_voidUpdateRowWithArray:", arrayTagGroup);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTagGroups];
        [UniversalFunctions SQL_TAGGROUPS_voidUpdateRowWithArray: arrayTagGroup];
        
    }
    
}

+ (void)SQL_TAGGROUPS_voidDeleteRowWithArray:(const NSArray *)arrayTagGroup {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTagGroups]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM TagGroups where id = %d;", [[[arrayTagGroup optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGGROUPS_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGGROUPS_voidDeleteRowWithArray:", arrayTagGroup);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTagGroups];
        [UniversalFunctions SQL_TAGGROUPS_voidDeleteRowWithArray: arrayTagGroup];
        
    }
    
}

@end

#pragma mark UniversalFunctions category (TAGGRUOPS_)

@implementation UniversalFunctions (TAGGRUOPS_)

+ (NSArray *)TAGGROUPS_returnGroupedTags {
    return [self TAGGROUPS_returnGroupedTagsWithTagGroups: [UniversalFunctions SQL_returnContentsOfTable: CTSQLTagGroups]];
    
}

/*
 * arrayGroup
 ** arrayTag
 *...
 ** dictionary -> NSArray : tagGroup
 */

+ (NSArray *)TAGGROUPS_returnGroupedTagsWithTagGroups:(const NSArray *)arrayTagGruops {
    NSMutableArray *arrayGroups = [NSMutableArray array];
    NSArray *arrayTags = [UniversalFunctions SQL_returnContentsOfTable: CTSQLTags];
    for (NSArray *arrayGroup in arrayTagGruops)
        [arrayGroups addObject: [NSMutableArray arrayWithObjects: @{@"group" : arrayGroup}, nil]];
    [arrayGroups insertObject: [NSMutableArray arrayWithObjects: @{@"group" : [NSArray arrayNEWTagGroupWithTitle: @"Ungrouped Tags" dateCreated: [NSDate date] options: [NSMutableDictionary dictionaryWithObjectsAndKeys: @0, @"id", nil]]}, nil] atIndex: 0];
    
    for (NSArray *arrayTag in arrayTags) {
        for (int groupIndex = 0; groupIndex < [arrayGroups count]; groupIndex += 1) {
            if ([[[arrayTag optionsDictionary] objectForKey: @"groupID"] isEqualToNumber: [[[[[arrayGroups objectAtIndex: groupIndex] lastObject] objectForKey: @"group"] optionsDictionary] objectForKey: @"id"]]) {
                [[arrayGroups objectAtIndex: groupIndex] insertObject: arrayTag atIndex: 0];
                break;
                
            }
            
        }
        
    }
    
    //Sort Tags within each Group
    for (NSMutableArray *arrayGroup in arrayGroups) {
        [arrayGroup sortUsingComparator: ^NSComparisonResult(id a, id b) {
            
            if ([a isKindOfClass: [NSArray class]] && [b isKindOfClass: [NSArray class]]) {
                NSString *stringA = [[a objectTag_title] lowercaseString];
                NSString *stringB = [[b objectTag_title] lowercaseString];
                
                return [stringA compare: stringB];
                
            } else
                return NSOrderedSame;
            
        }];
        
    }
    
    //Sort Grouped Tags by the First Letter of Group Title
    [arrayGroups sortUsingComparator: ^NSComparisonResult(id a, id b) {
        NSString *stringA = [[[[a lastObject] objectForKey: @"group"] objectTagGroup_title] lowercaseString];
        NSString *stringB = [[[[b lastObject] objectForKey: @"group"] objectTagGroup_title] lowercaseString];
        
        if ([stringA isEqualToString: @"ungrouped tags"] || [stringB isEqualToString: @"ungrouped tags"])
            return NSOrderedSame;
        else
            return [stringA compare: stringB];
        
    }];
    
    return arrayGroups;
    
}

+ (NSArray *)TAGGROUPS_returnCopyOfTagsWithTagGroups:(const NSArray *)arrayTagGroups {
    NSMutableArray *array = [NSMutableArray array];
    for (int groupIndex = 0; groupIndex < [arrayTagGroups count]; groupIndex += 1) {
        [array addObject: [NSMutableArray array]];
        for (int objectIndex = 0; objectIndex < [[arrayTagGroups objectAtIndex: groupIndex] count]; objectIndex += 1) {
            id object = [[arrayTagGroups objectAtIndex: groupIndex] objectAtIndex: objectIndex];
            if ([object isKindOfClass: [NSArray class]])
                [[array objectAtIndex: groupIndex] addObject: object];
            
        }
        
    }
    
    return array;
    
}

@end

#pragma mark - Tags

#pragma mark NSArray category (ARRAY_TAGS_)

@implementation NSArray (ARRAY_TAGS_)

+ (id)arrayNEWTag {
    return [NSMutableArray arrayNEWTagWithTitle: @"Untitled"];
    
}

+ (id)arrayNEWTagWithTitle:(NSString *)stringTitleValue {
    return [NSMutableArray arrayNEWTagWithTitle: stringTitleValue dateCreated: [NSDate date]];
    
}

+ (id)arrayNEWTagWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue {
    return [NSMutableArray arrayNEWTagWithTitle: stringTitleValue dateCreated: dateCreatedValue options: [NSMutableDictionary dictionaryWithObjectsAndKeys: @0, @"groupID", nil]];
    
}

+ (id)arrayNEWTagWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: stringTitleValue, dateCreatedValue, dicIndex, nil];
    
}

- (NSString *)objectTag_title {
    return [self objectAtIndex: TAGS_title];
    
}

- (NSDate *)objectTag_dateCreated {
    return [self objectAtIndex: TAGS_dateCreated];
    
}

@end

#pragma mark UniversalVariables category (TAGS_)

@implementation UniversalVariables (TAGS_)

- (void)TAGS_writeNewForTag:(NSArray *)arrayTag {
    [UniversalFunctions SQL_TAGS_voidInsertRowWithArray: arrayTag];
    
}

- (void)TAGS_updateForTag:(NSArray *)arrayTag {
    [UniversalFunctions SQL_TAGS_voidUpdateRowWithArray: arrayTag];
    
}

- (void)TAGS_deleteForTag:(NSArray *)arrayTag {
    [UniversalFunctions SQL_TAGS_voidDeleteRowWithArray: arrayTag];
    
}

@end

#pragma mark UniversalFunctions category (SQL_TAGS_)

@implementation UniversalFunctions (SQL_TAGS_)

+ (void)SQL_TAGS_voidInsertRowWithArray:(const NSArray *)arrayTag {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTags]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO Tags (title, dateCreated, groupID) values (\"%@\", \"%@\", %d);", [[arrayTag objectTag_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayTag objectTag_dateCreated]], [[[arrayTag optionsDictionary] objectForKey: @"groupID"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGS_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGS_voidInsertRowWithArray:", arrayTag);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTags];
        [UniversalFunctions SQL_TAGS_voidInsertRowWithArray: arrayTag];
        
    }
    
}

+ (void)SQL_TAGS_voidUpdateRowWithArray:(const NSArray *)arrayTag {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTags]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Tags SET title = \"%@\", dateCreated = \"%@\", groupID = %d where id = %d;", [[arrayTag objectTag_title] stringByReformatingForSQLQuries], [dateFormatter stringFromDate: [arrayTag objectTag_dateCreated]], [[[arrayTag optionsDictionary] objectForKey: @"groupID"] intValue], [[[arrayTag optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGS_voidUpdateRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGS_voidUpdateRowWithArray:", arrayTag);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTags];
        [UniversalFunctions SQL_TAGS_voidUpdateRowWithArray: arrayTag];
        
    }
    
}

+ (void)SQL_TAGS_voidDeleteRowWithArray:(const NSArray *)arrayTag {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTags]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM Tags where id = %d;", [[[arrayTag optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGS_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGS_voidDeleteRowWithArray:", arrayTag);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTags];
        [UniversalFunctions SQL_TAGS_voidDeleteRowWithArray: arrayTag];
        
    }
    
}

+ (void)SQL_TAGS_voidAssignTagsToUngrouppedTagsForTagGroupID:(NSUInteger)groupID {
    [UniversalFunctions SQL_TAGS_voidAssignTagsToTagGroup: 0 fromTagGroup: groupID];
    
}

+ (void)SQL_TAGS_voidAssignTagsToTagGroup:(NSUInteger)toIndex fromTagGroup:(NSUInteger)fromIndex {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTags]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE Tags SET groupID = %d where groupID = %d;", (int)toIndex, (int)fromIndex];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Update Table: +SQL_TAGS_voidAssignTagsToTagGroup:fromTagGroup:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Updated Table: %d to %d: +SQL_TAGS_voidAssignTagsToTagGroup:fromTagGroup:", (int)fromIndex, (int)toIndex);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTags];
        [UniversalFunctions SQL_TAGS_voidAssignTagsToTagGroup: toIndex fromTagGroup: fromIndex];
        
    }
    
}

@end

#pragma mark UniversalFunctions category (TAGS_)

@implementation UniversalFunctions (TAGS_)

+ (NSArray *)TAGS_returnGroupedTags {
    return [self TAGS_returnGroupedTagsWithTags: [UniversalFunctions SQL_returnContentsOfTable: CTSQLTags]];
    
}

+ (NSArray *)TAGS_returnGroupedTagsWithTags:(const NSArray *)arrayTags {
    NSMutableArray *arrayGroupedTags = [NSMutableArray array];
    
    for (NSArray *arrayTag in arrayTags) {
        if ([arrayGroupedTags count] > 0) {
            BOOL isFound = false;
            for (int index = 0; index < [arrayGroupedTags count]; index += 1) {
                if ([[[[arrayGroupedTags objectAtIndex: index] lastObject] objectForKey: @"letter"] isEqualToString: [[[arrayTag objectTag_title] substringToIndex: 1] uppercaseString]]) {
                    [[arrayGroupedTags objectAtIndex: index] insertObject: arrayTag atIndex: 0];
                    isFound = true;
                    break;
                    
                }
                
            }
            if (!isFound)
                [arrayGroupedTags addObject: [NSMutableArray arrayWithObjects: arrayTag, @{@"letter": [[[arrayTag objectTag_title] substringToIndex: 1] uppercaseString]}, nil]];
            
        } else
            [arrayGroupedTags addObject: [NSMutableArray arrayWithObjects: arrayTag, @{@"letter": [[[arrayTag objectTag_title] substringToIndex: 1] uppercaseString]}, nil]];
        
    }
    
    //Sort Letters within each Group
    for (NSMutableArray *arrayGroup in arrayGroupedTags) {
        [arrayGroup sortUsingComparator: ^NSComparisonResult(id a, id b) {
            
            if ([a isKindOfClass: [NSArray class]] && [b isKindOfClass: [NSArray class]]) {
                NSString *stringA = [[a objectTag_title] lowercaseString];
                NSString *stringB = [[b objectTag_title] lowercaseString];
                
                return [stringA compare: stringB];
                
            } else
                return NSOrderedSame;
            
        }];
        
    }
    
    //Sort Grouped Tags by the First Letter of Title
    [arrayGroupedTags sortUsingComparator: ^NSComparisonResult(id a, id b) {
        NSString *stringA = [[[a lastObject] objectForKey: @"letter"] lowercaseString];
        NSString *stringB = [[[b lastObject] objectForKey: @"letter"] lowercaseString];
        
        return [stringA compare: stringB];
        
    }];
    
    return arrayGroupedTags;
    
}

+ (void)TAGS_voidRemoveDuplicateChangesForDictionary:(NSMutableDictionary *)dictionary {
    NSUInteger index = 0;
    while (index < [[dictionary objectForKey: @"insert"] count]) {
        BOOL isFound = false;
        NSUInteger subindex = 0;
        while (subindex < [[dictionary objectForKey: @"delete"] count]) {
            if ([[[dictionary objectForKey: @"insert"] objectAtIndex: index] isEqualToNumber: [[dictionary objectForKey: @"delete"] objectAtIndex: subindex]]) {
                [[dictionary objectForKey: @"insert"] removeObjectAtIndex: index];
                [[dictionary objectForKey: @"delete"] removeObjectAtIndex: subindex];
                isFound = true;
                break;
                
            }
            
        }
        if (!isFound)
            index += 1;
        
    }
    
}

@end

#pragma mark - TagEntriesRelationship

#pragma mark NSArray category (ARRAY_TAGENTRIES_)

@implementation NSArray (ARRAY_TAGENTRIES_)

+ (id)arrayNEWTagEntriesRelationship {
    return [NSMutableArray arrayNEWTagEntriesRelationshipWithTagID: @0 entryID: @0];
    
}

+ (id)arrayNEWTagEntriesRelationshipWithTagID:(NSNumber *)tagID entryID:(NSNumber *)entryID {
    return [NSMutableArray arrayNEWTagEntriesRelationshipWithTagID: tagID entryID: entryID options: [NSMutableDictionary dictionary]];
    
}

+ (id)arrayNEWTagEntriesRelationshipWithTagID:(NSNumber *)tagID entryID:(NSNumber *)entryID options:(NSMutableDictionary *)dicIndex {
    return [NSMutableArray arrayWithObjects: tagID, entryID, dicIndex, nil];
    
}

- (NSNumber *)objectTagEntry_tagID {
    return [self objectAtIndex: TAGENTRIES_tagID];
    
}

- (NSNumber *)objectTagEntry_entryID {
    return [self objectAtIndex: TAGENTRIES_entryID];
    
}

@end

#pragma mark UniversalVariables category (TAGENTRIES_)

@implementation UniversalVariables (TAGENTRIES_)

- (void)TAGENTRIES_writeNewForTagEntryRelationship:(NSArray *)arrayRelationship {
    [UniversalFunctions SQL_TAGENTRIES_voidInsertRowWithArray: arrayRelationship];
    
}

- (void)TAGENTRIES_updateForTagEntryRelationship:(NSArray *)arrayRelationship {
    [UniversalFunctions SQL_TAGENTRIES_voidUpdateRowWithArray: arrayRelationship];
    
}

- (void)TAGENTRIES_deleteForTagEntryRelationship:(NSArray *)arrayRelationship {
    [UniversalFunctions SQL_TAGENTRIES_voidDeleteRowWithArray: arrayRelationship];
    
}

@end

#pragma mark UniversalFunctions category (SQL_TAGENTRIES_)

@implementation UniversalFunctions (SQL_TAGENTRIES_)

+ (void)SQL_TAGENTRIES_voidInsertRowWithArray:(const NSArray *)arrayRelationship {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTagEntriesRelationship]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"INSERT INTO TagEntriesRelationship (tagID, entryID) values (%d, %d);", [[arrayRelationship objectTagEntry_tagID] intValue], [[arrayRelationship objectTagEntry_entryID] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGENTRIES_voidInsertRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGENTRIES_voidInsertRowWithArray:", arrayRelationship);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTagEntriesRelationship];
        [UniversalFunctions SQL_TAGENTRIES_voidInsertRowWithArray: arrayRelationship];
        
    }
    
}

+ (void)SQL_TAGENTRIES_voidUpdateRowWithArray:(const NSArray *)arrayRelationship {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTagEntriesRelationship]) {
        static ISO8601DateFormatter *dateFormatter = nil;
        if (!dateFormatter)
            dateFormatter = [[ISO8601DateFormatter alloc] init];
        [dateFormatter setIncludeTime: YES];
        
        NSString *sqlStatement = [NSString stringWithFormat: @"UPDATE TagEntriesRelationship SET tagID = %d, entryID = %d where id = %d;", [[arrayRelationship objectTagEntry_tagID] intValue], [[arrayRelationship objectTagEntry_entryID] intValue], [[[arrayRelationship optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGENTRIES_voidUpdateRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGENTRIES_voidUpdateRowWithArray:", arrayRelationship);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTagEntriesRelationship];
        [UniversalFunctions SQL_TAGENTRIES_voidUpdateRowWithArray: arrayRelationship];
        
    }
    
}

+ (void)SQL_TAGENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayRelationship {
    if ([UniversalFunctions SQL_returnStatusOfTable: CTSQLTagEntriesRelationship]) {
        NSString *sqlStatement = [NSString stringWithFormat: @"DELETE FROM TagEntriesRelationship where id = %d;", [[[arrayRelationship optionsDictionary] objectForKey: @"id"] intValue]];
        char *err;
        if (!SQLQueryMake( [[UniversalVariables globalVariables] database], sqlStatement, &err)) {
            sqlite3_close( [[UniversalVariables globalVariables] database]);
            NSLog( @"***Failed to Add to Table: +SQL_TAGENTRIES_voidDeleteRowWithArray:");
            NSAssert( 0, [NSString stringWithUTF8String: err]);
            
        } else
            NSLog( @"Added to Table: %@: +SQL_TAGENTRIES_voidDeleteRowWithArray:", arrayRelationship);
        
    } else {
        [UniversalFunctions SQL_voidCreateTable: CTSQLTagEntriesRelationship];
        [UniversalFunctions SQL_TAGENTRIES_voidDeleteRowWithArray: arrayRelationship];
        
    }
    
}

@end

#pragma mark UniversalFunctions category (TAGENTRIES_)

@implementation UniversalFunctions (TAGENTRIES_)

@end

#pragma mark - Outlines

#pragma mark NSArray category (ARRAY_OUTLINES_)

@implementation NSArray (ARRAY_OUTLINES_)

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
    
    if (SQLQueryPrepare( [[UniversalVariables globalVariables] database], [NSString stringWithFormat: @"SELECT * FROM Diaries where id = %d;", [[[arrayOutine optionsDictionary] objectForKey: @"diaryID"] intValue]], &statement, &err)) {
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

#pragma mark UniversalFunctions category (SQL_OUTLINES_)

@implementation UniversalFunctions (SQL_OUTLINES_)

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
