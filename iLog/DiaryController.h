//
//  DiaryController.h
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>


static CGFloat CVDiaryEntryIconImageSize = 36;
static CGFloat CVDiaryEntryIconImageSize_enlarged = 98;

@interface DiaryController : NSObject

@end

#import "DiaryController+CoreData.h"

#pragma mark - Diaries

#pragma mark NSArray category (ARRAY_Diaries_)

static const NSUInteger DIARY_title = 0;
static const NSUInteger DIARY_dateCreated = 1;
static const NSUInteger DIARY_colorTrait = 2;
static const NSUInteger DIARY_isProtected = 3;
static const NSUInteger DIARY_passcode = 4;
static const NSUInteger DIARY_maskTitle = 5;

@interface NSArray (ARRAY_Diaries_)

+ (id)arrayNEWDiary;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue;
+ (id)arrayNEWDiaryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue index:(NSMutableDictionary *)dicIndex;
- (NSString *)objectDiary_title;
- (NSDate *)objectDiary_dateCreated;
- (CDColorTraits)objectDiary_colorTrait;
- (BOOL)objectDiary_isProtected;
- (NSString *)objectDiary_passcode;
- (NSString *)objectDiary_maskTitle;

@end

#pragma mark UniversalVariables category (DIARIES_)

@interface UniversalVariables (DIARIES_)

- (void)DIARIES_writeNewForDiary:(NSArray *)arrayDiary;
- (void)DIARIES_updateForDiary:(NSArray *)arrayDiary;
- (void)DIARIES_deleteForDiary:(NSArray *)arrayDiary;

- (NSArray *)DIARIES_returnFirstDiary;
- (NSMutableDictionary *)DIARIES_returnDiaryOptionsForDiary:(NSArray *)arrayDiary;

@end

#pragma mark UniversalFunctions category (SQL_DIARIES_)

static const int SQL_DIARY_id = 0;
static const int SQL_DIARY_title = 1;
static const int SQL_DIARY_dateCreated = 2;
static const int SQL_DIARY_colorTrait = 3;
static const int SQL_DIARY_isProtected = 4;
static const int SQL_DIARY_passcode = 5;
static const int SQL_DIARY_maskTitle = 6;

/**
 * From the parameter list, an array is produced in Diary format
 * @param [in] statement incoming value from previous call SQLSTatementStep(..)
 * @return NSArray: Diary format
 */
static inline NSMutableArray * SQLStatementRowIntoDiaryEntry( sqlite3_stmt *statement) {
    NSString *stringTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_DIARY_title)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_DIARY_dateCreated)]];
    
    CDColorTraits colorTrait = sqlite3_column_int( statement, SQL_DIARY_colorTrait);
    bool isProtected = sqlite3_column_int( statement, SQL_DIARY_isProtected);
    NSString *stringPasscode = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_DIARY_passcode)];
    NSString *stringMaskTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_DIARY_maskTitle)];
    
    NSMutableArray *array = [NSMutableArray arrayNEWDiaryWithTitle: stringTitle dateCreated: dateCreated colorTrait: colorTrait isProtected: isProtected passcode: stringPasscode maskTitle: stringMaskTitle index: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_DIARY_id)], @"id", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_Diaries_)

/**
 * Inserts a row to the table Diaries
 * @param [in] arrayEntry: Diaries
 */
+ (void)SQL_DIARIES_voidInsertRowWithArray:(const NSArray *)arrayEntry;
/**
 * Updates an exisiting row to the table Diaries
 * @param [in] arrayEntry: Diaries
 */
+ (void)SQL_DIARIES_voidUpdateRowForArray:(const NSArray *)arrayEntry;
/**
 * Deletes a row to the table Diaries
 * @param [in] arrayEntry: Diaries
 */
+ (void)SQL_DIARIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry;

@end

#pragma mark NSArray category (ARRAY_Entries_)

static const NSUInteger ENTRIES_subject = 0;
static const NSUInteger ENTRIES_date = 1;
static const NSUInteger ENTRIES_dateCreated = 2;
static const NSUInteger ENTRIES_body = 3;
static const NSUInteger ENTRIES_startDate = 4;
static const NSUInteger ENTRIES_emotion = 5;
static const NSUInteger ENTRIES_emotionScale = 6;
static const NSUInteger ENTRIES_weatherCondition = 7;
static const NSUInteger ENTRIES_temperature = 8;
static const NSUInteger ENTRIES_temperatureValue = 9;
static const NSUInteger ENTRIES_isBookmarked = 10;

@interface NSArray (ARRAY_Entries_)

+ (id)arrayNEWEntry;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue body:(NSString *)stringBodyValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue startDate:(NSDate *)dateStartValue emotion:(CDEntryEmotions)emotionValue emotionScale:(int)emotionScaleValue weatherCondition:(CDEntryWeatherCondition)weatherValue temperature:(CDEntryTemerature)temperatureValue temperatureValue:(int)temperatureValueValue isBookmarked:(BOOL)boolBookmarkedValue;
+ (id)arrayNEWEntryWithSubject:(NSString *)stringSubjectValue date:(NSDate *)dateValue dateCreated:(NSDate *)dateCreatedValue body:(NSString *)stringBodyValue startDate:(NSDate *)dateStartValue emotion:(CDEntryEmotions)emotionValue emotionScale:(int)emotionScaleValue weatherCondition:(CDEntryWeatherCondition)weatherValue temperature:(CDEntryTemerature)temperatureValue temperatureValue:(int)temperatureValueValue isBookmarked:(BOOL)boolBookmarkedValue options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectEntry_subject;
- (NSDate *)objectEntry_date;
- (NSDate *)objectEntry_dateCreated;
- (NSString *)objectEntry_body;
- (NSDate *)objectEntry_startDate;
- (CDEntryEmotions)objectEntry_emotion;
- (int)objectEntry_emotionScale;
- (CDEntryWeatherCondition)objectEntry_weatherCondition;
- (CDEntryTemerature)objectEntry_temperature;
- (int)objectEntry_temperatureValue;
- (BOOL)objectEntry_isBookmarked;

@end

#pragma mark UniversalVariables category (ENTRIES_)

@interface UniversalVariables (ENTRIES_)

- (void)ENTRIES_writeNewForEntry:(NSArray *)arrayEntry;
- (void)ENTRIES_updateForEntry:(NSArray *)arrayEntry;
- (void)ENTRIES_deleteForEntry:(NSArray *)arrayEntry;

- (NSMutableDictionary *)ENTRIES_returnEntryOptionsForEntry:(NSArray *)arrayEntry;

@end

#pragma mark UniversalFunctions category (SQL_Entries_)

static const int SQL_ENTRIES_id = 0;
static const int SQL_ENTRIES_diaryID = 1;
static const int SQL_ENTRIES_subject = 2;
static const int SQL_ENTRIES_date = 3;
static const int SQL_ENTRIES_dateCreated = 4;
static const int SQL_ENTRIES_body = 5;
static const int SQL_ENTRIES_startDate = 6;
static const int SQL_ENTRIES_emotion = 7;
static const int SQL_ENTRIES_emotionSacle = 8;
static const int SQL_ENTRIES_weatherCondition = 9;
static const int SQL_ENTRIES_temperature = 10;
static const int SQL_ENTRIES_temperatureValue = 11;
static const int SQL_ENTRIES_isBookmarked = 12;

/**
 * From the parameter list, an array is produced in Entry format
 * @param [in] statement incoming value from previous call SQLSTatementStep(..)
 * @return NSArray: Entry format
 */
static inline NSMutableArray * SQLStatementRowIntoEntryEntry( sqlite3_stmt *statement) {
    NSString *stringSubject = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_subject)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *date = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_date)]];
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_dateCreated)]];
    
    NSString *stringBody = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_body)];
    
    NSDate *dateStart = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_ENTRIES_startDate)]];
    
    CDEntryEmotions emotion = sqlite3_column_int( statement, SQL_ENTRIES_emotion);
    int emotionScale = sqlite3_column_int( statement, SQL_ENTRIES_emotionSacle);
    CDEntryWeatherCondition weatherCondition = sqlite3_column_int( statement, SQL_ENTRIES_weatherCondition);
    CDEntryTemerature temperature = sqlite3_column_int( statement, SQL_ENTRIES_temperature);
    int temperatureValue = sqlite3_column_int( statement, SQL_ENTRIES_temperatureValue);
    BOOL isBookmarked = sqlite3_column_int( statement, SQL_ENTRIES_isBookmarked);
    
    NSMutableArray *array = [NSMutableArray arrayNEWEntryWithSubject: stringSubject date: date dateCreated: dateCreated body: stringBody startDate: dateStart emotion: emotion emotionScale: emotionScale weatherCondition: weatherCondition temperature: temperature temperatureValue: temperatureValue isBookmarked: isBookmarked options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_ENTRIES_id)], @"id", [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_ENTRIES_diaryID)], @"diaryID", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_Entries_)

/**
 * Inserts a row to the table Entries
 * @param [in] arrayEntry: Entries
 */
+ (void)SQL_ENTRIES_voidInsertRowWithArray:(const NSArray *)arrayEntry;
/**
 * Updates an exisiting row to the table Entries
 * @param [in] arrayEntry: Entries
 */
+ (void)SQL_ENTRIES_voidUpdateRowForArray:(const NSArray *)arrayEntry;
/**
 * Deletes a row to the table Entries
 * @param [in] arrayEntry: Entries
 */
+ (void)SQL_ENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayEntry;

+ (void)SQL_ENTRIES_voidApplyChangesWithArray:(const NSArray *)arrayEntry;

@end

#pragma mark - Stories

#pragma mark NSArray category (ARRAY_STORIES_)

static const NSUInteger STORIES_title = 0;
static const NSUInteger STORIES_dateCreated = 1;
static const NSUInteger STORIES_description = 2;
static const NSUInteger STORIES_colorTrait = 3;
static const NSUInteger STORIES_isProtected = 4;
static const NSUInteger STORIES_passcode = 5;
static const NSUInteger STORIES_maskTitle = 6;
static const NSUInteger STORIES_authenticationRequired = 7;

@interface NSArray (ARRAY_STORIES_)

+ (id)arrayNEWStory;
+ (id)arrayNEWStoryWithTitle:(NSString *)stringTitleValue description:(NSString *)stringDescriptionValue;
+ (id)arrayNEWStoryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue description:(NSString *)stringDescriptionValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolIsProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue authenticationRequired:(BOOL)boolAuthenRequired;
+ (id)arrayNEWStoryWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue description:(NSString *)stringDescriptionValue colorTrait:(CDColorTraits)colorTraitValue isProtected:(BOOL)boolIsProtectedValue passcode:(NSString *)stringPasscodeValue maskTitle:(NSString *)stringMaskTitleValue authenticationRequired:(BOOL)boolAuthenRequired options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectStory_title;
- (NSDate *)objectStory_dateCreated;
- (NSString *)objectStory_description;
- (CDColorTraits)objectStory_colorTrait;
- (BOOL)objectStory_isProtected;
- (NSString *)objectStory_passcode;
- (NSString *)objectStory_maskTitle;
- (BOOL)objectStory_authenticationRequired;

@end

#pragma mark UniversalVariables category (STORIES_)

@interface UniversalVariables (STORIES_)

- (void)STORIES_writeNewForStory:(NSArray *)arrayStory;
- (void)STORIES_updateForStory:(NSArray *)arrayStory;
- (void)STORIES_deleteForStory:(NSArray *)arrayStory;

- (NSMutableDictionary *)STORIES_returnStoryOptionsForStory:(NSArray *)arrayStory;

@end

#pragma mark UniversalFunctions category (SQL_STORIES_)

static const int SQL_STORIES_id = 0;
static const int SQL_STORIES_diaryID = 1;
static const int SQL_STORIES_title = 2;
static const int SQL_STORIES_dateCreated = 3;
static const int SQL_STORIES_description = 4;
static const int SQL_STORIES_colorTrait = 5;
static const int SQL_STORIES_isProtected = 6;
static const int SQL_STORIES_passcode = 7;
static const int SQL_STORIES_maskTitle = 8;
static const int SQL_STORIES_authenticationRequired = 9;

/**
 * From the parameter list, an array is produced in Story format
 * @param [in] statement incoming value from previous call SQLStatementStep(..)
 * @return NSArray: Story format
 */
static inline NSMutableArray * SQLStatementRowIntoStoryEntry( sqlite3_stmt *statement) {
    NSString *stringTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_STORIES_title)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_STORIES_dateCreated)]];
    NSString *stringDescription = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_STORIES_description)];
    
    CDColorTraits colorTrait = sqlite3_column_int( statement, SQL_STORIES_colorTrait);
    
    BOOL isProtected = sqlite3_column_int( statement, SQL_STORIES_isProtected);
    NSString *stringPasscode = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_STORIES_passcode)];
    NSString *stringMaskTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_STORIES_maskTitle)];
    BOOL authenticationRequired = sqlite3_column_int( statement, SQL_STORIES_authenticationRequired);
    
    NSMutableArray *array = [NSMutableArray arrayNEWStoryWithTitle: stringTitle dateCreated: dateCreated description: stringDescription colorTrait: colorTrait isProtected: isProtected passcode: stringPasscode maskTitle: stringMaskTitle authenticationRequired: authenticationRequired options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_STORIES_id)], @"id", [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_STORIES_diaryID)], @"diaryID", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_STORIES_)

/**
 * Inserts a row to the table Story
 * @param [in] arrayEntry: Story
 */
+ (void)SQL_STORIES_voidInsertRowWithArray:(const NSArray *)arrayStory;
/**
 * Updates an existing row to the table Story
 * @param [in] arrayEntry: Story
 */
+ (void)SQL_STORIES_voidUpdateRowWithArray:(const NSArray *)arrayStory;
/**
 * Deletes a row to the table Story
 * @param [in] arrayEntry: Story
 */
+ (void)SQL_STORIES_voidDeleteRowWithArray:(const NSArray *)arrayStory;

@end

#pragma mark UniversalFunctions category (STORIES_)

@interface UniversalFunctions (STORIES_)

/**
 * Grouping stroies in an array with a similary key of the corresponding diary title
 * @warning Each array of Stories is then sorted in ascending aplabetical order
 * @return NSarray : values -> Story Format
 */
+ (NSArray *)STORIES_returnGroupedStories;
+ (NSArray *)STORIES_returnGroupedStoriesWithStories:(const NSArray *)arrayStories;

@end

#pragma mark - StoriesEntriesRelationship

#pragma mark NSArray category (ARRAY_STORYENTRIES_)

static const NSUInteger STORYENTRIES_tagID = 0;
static const NSUInteger STORYENTRIES_entryID = 1;

@interface NSArray (ARRAY_STORYENTRIES_)

+ (id)arrayNEWStoryEntriesRelationship;
+ (id)arrayNEWStoryEntriesRelationshipWithStoryID:(NSNumber *)storyID entryID:(NSNumber *)entryID;
+ (id)arrayNEWStoryEntriesRelationshipWithStoryID:(NSNumber *)storyID entryID:(NSNumber *)entryID options:(NSMutableDictionary *)dicIndex;
- (NSNumber *)objectStoryEntry_storyID;
- (NSNumber *)objectStoryEntry_entryID;

@end

#pragma mark UniversalVariables category (STORYENTRIES_)

@interface UniversalVariables (STORYENTRIES_)

- (void)STORYENTRIES_writeNewForStoryEntryRelationship:(NSArray *)arrayRelationship;
- (void)STORYENTRIES_updateForStoryEntryRelationship:(NSArray *)arrayRelationship;
- (void)STORYENTRIES_deleteForStoryEntryRelationship:(NSArray *)arrayRelationship;

- (NSMutableDictionary *)STORYENTRIES_returnOptionsForTagEntryRelationship:(NSArray *)arrayRelationship;

@end

#pragma mark UniversalFunctions category (SQL_TAGENTRIES_)

static const int SQL_STORYENTRIES_id = 0;
static const int SQL_STORYENTRIES_storyid = 1;
static const int SQL_STORYENTRIES_entryid = 2;

/**
 * From the parameter list, an array is produced in StoryEntryRelationship format
 * @param [in] statement incoming value from previous call SQLStatementStep(..)
 * @return NSArray: StoryEntryRelationship format
 */
static inline NSMutableArray * SQLStatementRowIntoStoryEntryRelationshipEntry( sqlite3_stmt *statement) {
    NSNumber *numberStoryID = [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_STORYENTRIES_storyid)];
    NSNumber *numberEntryID = [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_STORYENTRIES_entryid)];
    
    NSMutableArray *array = [NSMutableArray arrayNEWStoryEntriesRelationshipWithStoryID: numberStoryID entryID: numberEntryID options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_STORYENTRIES_id)], @"id", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_STORYENTRIES_)

/**
 * Inserts a row to the table StoryEntriesRelationship
 * @param [in] arrayEntry: StoryEntryRelationship
 */
+ (void)SQL_STORYENTRIES_voidInsertRowWithArray:(const NSArray *)arrayRelationship;
/**
 * Updates an existing row to the table StoryEntriesRelationship
 * @param [in] arrayEntry: StoryEntryRelationship
 */
+ (void)SQL_STORYENTRIES_voidUpdateRowWithArray:(const NSArray *)arrayRelationship;
/**
 * Deletes a row to the table StoryEntriesRelationship
 * @param [in] arrayEntry: StoryEntryRelationship
 */
+ (void)SQL_STORYENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayRelationship;

@end

#pragma mark UniversalFunctions category (STORYENTRIES_)

@interface UniversalFunctions (STORYENTRIES_)

@end

#pragma mark - Tag Groups

#pragma mark NSArray category (ARRAY_TAGGROUPS_)

static const NSUInteger TAGGROUPS_title = 0;
static const NSUInteger TAGGROUPS_dateCreated = 1;

@interface NSArray (ARRAY_TAGGROUPS_)

+ (id)arrayNEWTagGroup;
+ (id)arrayNEWTagGroupWithTitle:(NSString *)stringTitleValue;
+ (id)arrayNEWTagGroupWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue;
+ (id)arrayNEWTagGroupWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectTagGroup_title;
- (NSDate *)objectTagGroup_dateCreated;

@end

#pragma mark UniversalVariables category (TAGGROUPS_)

@interface UniversalVariables (TAGGROUPS_)

- (void)TAGGROUPS_writeNewForTagGroup:(NSArray *)arrayTagGroup;
- (void)TAGGROUPS_updateForTagGroup:(NSArray *)arrayTagGroup;
- (void)TAGGROUPS_deleteForTagGroup:(NSArray *)arrayTagGroup;

- (NSMutableDictionary *)TAGGROUPS_returnOptionsForTagGroup:(NSArray *)arrayTagGroup;

@end

#pragma mark UniversalFunctions category (SQL_TAGGROUPS_)

static const int SQL_TAGGROUPS_id = 0;
static const int SQL_TAGGROUPS_title = 1;
static const int SQL_TAGGROUPS_dateCreated = 2;

/**
 * From the parameter list, an array is produced in TagGroup format
 * @param [in] statement incoming value from previous call SQLStatementStep(..)
 * @return NSArray: TagGroup format
 */
static inline NSMutableArray * SQLStatementRowIntoTagGroupEntry( sqlite3_stmt *statement) {
    NSString *stringTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_TAGGROUPS_title)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_TAGGROUPS_dateCreated)]];
    
    NSMutableArray *array = [NSMutableArray arrayNEWTagGroupWithTitle: stringTitle dateCreated: dateCreated options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_TAGGROUPS_id)], @"id", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_TAGGROUPS_)

/**
 * Inserts a row to the table TagGroups
 * @param [in] arrayEntry: TagGroup
 */
+ (void)SQL_TAGGROUPS_voidInsertRowWithArray:(const NSArray *)arrayTagGroup;
/**
 * Updates an existing row to the table TagGroups
 * @param [in] arrayEntry: TagGroup
 */
+ (void)SQL_TAGGROUPS_voidUpdateRowWithArray:(const NSArray *)arrayTagGroup;
/**
 * Deletes a row to the table TagGroups
 * @param [in] arrayEntry: TagGroup
 */
+ (void)SQL_TAGGROUPS_voidDeleteRowWithArray:(const NSArray *)arrayTagGroup;

@end

#pragma mark UniversalFunctions category (TAGGRUOPS_)

@interface UniversalFunctions (TAGGRUOPS_)

/**
 * Grouping tag in a an array with a similary key of the corresponding tag title
 * @warning Each array of Tags is then sorted in ascending aplabetical order
 * @return NSarray : values -> Tag Format
 */
+ (NSArray *)TAGGROUPS_returnGroupedTags;
+ (NSArray *)TAGGROUPS_returnGroupedTagsWithTagGroups:(const NSArray *)arrayTagGruops;

/**
 * Used only to copy the formatted array created by +TAGGROUPS_returnGroupedTagsWithTagGroups: This only "copies" the tags, 
 * no information about the tagGroup
 * @return NSArray : tag format
 */
+ (NSArray *)TAGGROUPS_returnCopyOfTagsWithTagGroups:(const NSArray *)arrayTagGroups;

@end

#pragma mark - Tags

#pragma mark NSArray category (ARRAY_TAGS_)

static const NSUInteger TAGS_title = 0;
static const NSUInteger TAGS_dateCreated = 1;

@interface NSArray (ARRAY_TAGS_)

+ (id)arrayNEWTag;
+ (id)arrayNEWTagWithTitle:(NSString *)stringTitleValue;
+ (id)arrayNEWTagWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue;
+ (id)arrayNEWTagWithTitle:(NSString *)stringTitleValue dateCreated:(NSDate *)dateCreatedValue options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectTag_title;
- (NSDate *)objectTag_dateCreated;

@end

#pragma mark UniversalVariables category (TAGS_)

@interface UniversalVariables (TAGS_)

- (void)TAGS_writeNewForTag:(NSArray *)arrayTag;
- (void)TAGS_updateForTag:(NSArray *)arrayTag;
- (void)TAGS_deleteForTag:(NSArray *)arrayTag;

- (NSMutableDictionary *)TAGS_returnOptionsForTag:(NSArray *)arrayTag;

@end

#pragma mark UniversalFunctions category (SQL_TAGS_)

static const int SQL_TAGS_id = 0;
static const int SQL_TAGS_groupID = 1;
static const int SQL_TAGS_title = 2;
static const int SQL_TAGS_dateCreated = 3;

/**
 * From the parameter list, an array is produced in Tag format
 * @param [in] statement incoming value from previous call SQLStatementStep(..)
 * @return NSArray: Tag format
 */
static inline NSMutableArray * SQLStatementRowIntoTagEntry( sqlite3_stmt *statement) {
    NSString *stringTitle = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_TAGS_title)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_TAGS_dateCreated)]];
    
    NSMutableArray *array = [NSMutableArray arrayNEWTagWithTitle: stringTitle dateCreated: dateCreated options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_TAGS_id)], @"id", [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_TAGS_groupID)], @"groupID", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_TAGS_)

/**
 * Inserts a row to the table Tags
 * @param [in] arrayEntry: Tag
 */
+ (void)SQL_TAGS_voidInsertRowWithArray:(const NSArray *)arrayTag;
/**
 * Updates an existing row to the table Tags
 * @param [in] arrayEntry: Tag
 */
+ (void)SQL_TAGS_voidUpdateRowWithArray:(const NSArray *)arrayTag;
/**
 * Deletes a row to the table Tags
 * @param [in] arrayEntry: Tag
 */
+ (void)SQL_TAGS_voidDeleteRowWithArray:(const NSArray *)arrayTag;

/**
 * <#Description#>
 * @warning calls +SQL_TAGS_voidAssignTagsToTagGroup: 0 fromTagGroup: groupID
 * @param [in] groupID tags with this value as .groupID will be set to zero
 */
+ (void)SQL_TAGS_voidAssignTagsToUngrouppedTagsForTagGroupID:(NSUInteger)groupID;
/**
 * When deleteing a tag group with tags "inside" this deleting tag group, these tags will be assigned to
 * the ungroupped tags value, or zero
 * @param [in] toIndex destination index
 * @param [in] fromIndex tags with this value as .groupID will be set to toIndex
 */
+ (void)SQL_TAGS_voidAssignTagsToTagGroup:(NSUInteger)toIndex fromTagGroup:(NSUInteger)fromIndex;

@end

#pragma mark UniversalFunctions category (TAGS_)

@interface UniversalFunctions (TAGS_)

/**
 * Grouping tag in a an array with a similary key of the corresponding tag title
 * @warning Each array of Tags is then sorted in ascending aplabetical order
 * @return NSarray : values -> Tag Format
 */
+ (NSArray *)TAGS_returnGroupedTags;
+ (NSArray *)TAGS_returnGroupedTagsWithTags:(const NSArray *)arrayTags;

@end

#pragma mark - TagEntriesRelationship

#pragma mark NSArray category (ARRAY_TAGENTRIES_)

static const NSUInteger TAGENTRIES_tagID = 0;
static const NSUInteger TAGENTRIES_entryID = 1;

@interface NSArray (ARRAY_TAGENTRIES_)

+ (id)arrayNEWTagEntriesRelationship;
+ (id)arrayNEWTagEntriesRelationshipWithTagID:(NSNumber *)tagID entryID:(NSNumber *)entryID;
+ (id)arrayNEWTagEntriesRelationshipWithTagID:(NSNumber *)tagID entryID:(NSNumber *)entryID options:(NSMutableDictionary *)dicIndex;
- (NSNumber *)objectTagEntry_tagID;
- (NSNumber *)objectTagEntry_entryID;

@end

#pragma mark UniversalVariables category (TAGENTRIES_)

@interface UniversalVariables (TAGENTRIES_)

- (void)TAGENTRIES_writeNewForTagEntryRelationship:(NSArray *)arrayRelationship;
- (void)TAGENTRIES_updateForTagEntryRelationship:(NSArray *)arrayRelationship;
- (void)TAGENTRIES_deleteForTagEntryRelationship:(NSArray *)arrayRelationship;

- (NSMutableDictionary *)TAGENTRIES_returnOptionsForTagEntryRelationship:(NSArray *)arrayRelationship;

@end

#pragma mark UniversalFunctions category (SQL_TAGENTRIES_)

static const int SQL_TAGENTRIES_id = 0;
static const int SQL_TAGENTRIES_tagid = 1;
static const int SQL_TAGENTRIES_entryid = 2;

/**
 * From the parameter list, an array is produced in TagEntryRelationship format
 * @param [in] statement incoming value from previous call SQLStatementStep(..)
 * @return NSArray: TagEntryRelationship format
 */
static inline NSMutableArray * SQLStatementRowIntoTagEntryRelationshipEntry( sqlite3_stmt *statement) {
    NSNumber *numberTagID = [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_TAGENTRIES_tagid)];
    NSNumber *numberEntryID = [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_TAGENTRIES_entryid)];
    
    NSMutableArray *array = [NSMutableArray arrayNEWTagEntriesRelationshipWithTagID: numberTagID entryID: numberEntryID options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_TAGENTRIES_id)], @"id", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_TAGENTRIES_)

/**
 * Inserts a row to the table TagEntriesRelationship
 * @param [in] arrayEntry: TagEntryRelationship
 */
+ (void)SQL_TAGENTRIES_voidInsertRowWithArray:(const NSArray *)arrayRelationship;
/**
 * Updates an existing row to the table TagEntriesRelationship
 * @param [in] arrayEntry: TagEntryRelationship
 */
+ (void)SQL_TAGENTRIES_voidUpdateRowWithArray:(const NSArray *)arrayRelationship;
/**
 * Deletes a row to the table TagEntriesRelationship
 * @param [in] arrayEntry: TagEntryRelationship
 */
+ (void)SQL_TAGENTRIES_voidDeleteRowWithArray:(const NSArray *)arrayRelationship;

@end

#pragma mark UniversalFunctions category (TAGENTRIES_)

@interface UniversalFunctions (TAGENTRIES_)

@end

#pragma mark - Outlines

#pragma mark NSArray category (ARRAY_OUTLINES_)

static const NSUInteger OUTLINES_body = 0;
static const NSUInteger OUTLINES_dateCreated = 1;

@interface NSArray (ARRAY_OUTLINES_)

+ (id)arrayNEWOutline;
+ (id)arrayNEWOutlineWithBody:(NSString *)stringBodyValue;
+ (id)arrayNEWOutlineWithBody:(NSString *)stringBodyValue dateCreated:(NSDate *)dateCreatedValue;
+ (id)arrayNEWOutlineWithBody:(NSString *)stringBodyValue dateCreated:(NSDate *)dateCreatedValue options:(NSMutableDictionary *)dicIndex;
- (NSString *)objectOutline_body;
- (NSDate *)objectOutline_dateCreated;

@end

#pragma mark UniversalVariables category (OUTLINES_)

@interface UniversalVariables (OUTLINES_)

- (void)OUTLINES_writeNewForOutline:(NSArray *)arrayOutline;
- (void)OUTLINES_updateForOutline:(NSArray *)arrayOutline;
- (void)OUTLINES_deleteForOutline:(NSArray *)arrayOutline;

- (NSMutableDictionary *)OUTLINES_returnOutlineOptionsForOutline:(NSArray *)arrayOutine;

@end

#pragma mark UniversalFunctions category (SQL_OUTLINES_)

static const int SQL_OUTLINES_id = 0;
static const int SQL_OUTLINES_entryID = 1;
static const int SQL_OUTLINES_body = 2;
static const int SQL_OUTLINES_dateCreated = 3;

/**
 * From the parameter list, an array is produced in Outline format
 * @param [in] statement incoming value from previous call SQLSTatementStep(..)
 * @return NSArray: Outline format
 */
static inline NSMutableArray * SQLStatementRowIntoOutlineEntry( sqlite3_stmt *statement) {
    NSString *stringBody = [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_OUTLINES_body)];
    
    static ISO8601DateFormatter *dateFormatter = nil;
    if (!dateFormatter)
        dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime: YES];
    
    NSDate *dateCreated = [dateFormatter dateFromString: [NSString stringWithUTF8String: (char *) sqlite3_column_text( statement, SQL_OUTLINES_dateCreated)]];
    
    NSMutableArray *array = [NSMutableArray arrayNEWOutlineWithBody: stringBody dateCreated: dateCreated options: [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_OUTLINES_id)], @"id", [NSNumber numberWithInt: sqlite3_column_int( statement, SQL_OUTLINES_entryID)], @"entryID", nil]];
    
    return array;
    
};

@interface UniversalFunctions (SQL_OUTLINES_)

/**
 * Inserts a row to the table Outlines
 * @param [in] arrayEntry: Outlines
 */
+ (void)SQL_OUTLINES_voidInsertRowWithArray:(const NSArray *)arrayEntry;
/**
 * Updates an exisiting row to the table Outlines
 * @param [in] arrayEntry: Outlines
 */
+ (void)SQL_OUTLINES_voidUpdateRowForArray:(const NSArray *)arrayEntry;
/**
 * Deletes a row to the table Outlines
 * @param [in] arrayEntry: Outlines
 */
+ (void)SQL_OUTLINES_voidDeleteRowWithArray:(const NSArray *)arrayEntry;

@end

