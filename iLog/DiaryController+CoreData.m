//
//  DiaryController+CoreData.m
//  iLogs - Universal iOS
//
//  Created by Erick Sanchez on 1/11/17.
//  Copyright © 2017 Erick Sanchez. All rights reserved.
//

#import "DiaryController+CoreData.h"

static NSPersistentContainer *_container;

@implementation UniversalFunctions (DIARY_COREDATA_)

+ (NSPersistentContainer *)viewStore {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_container == nil) {
            _container = [[NSPersistentContainer alloc] initWithName:@"Diary-Model"];
            [_container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _container;
    
}

#pragma mark Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = [[UniversalFunctions viewStore] viewContext];
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end

#pragma mark - Entries

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
