//
//  CategoriesClasses.m
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "CategoriesClasses.h"

@implementation UIViewController (UIVIEWCONTROLER_)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag {
    [[UniversalVariables globalVariables] setCurrentView: viewControllerToPresent];
    [self presentViewController: viewControllerToPresent animated: flag completion: ^{ }];
    
}

@end


@implementation NSArray (ARRAY_)

- (NSMutableDictionary *)optionsDictionary {
    return (NSMutableDictionary *)[self lastObject];
    
}

@end

@implementation NSMutableArray (ARRAY_)

- (void)updateOptionsDictionary:(NSDictionary *)dictionaryValue {
    if ([[self lastObject] isKindOfClass: [NSMutableDictionary class]] || [[self lastObject] isKindOfClass: [NSDictionary class]]) {
        [self removeLastObject];
        [self addObject: dictionaryValue];
        
    }
    
}

@end

@implementation UIColor (HEXColors)

+ (UIColor *)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha: alpha];
    
}

@end

@implementation UIColor (CustomUIColor)

+ (UIColor *)incomeColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0 green: 0.5 blue: 0 alpha: alpha];
    
}

+ (UIColor *)expenseColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.75 green: 0 blue: 0 alpha: alpha];
    
}

+ (UIColor *)transferColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.502 green: 0 blue: 0.502 alpha: alpha];
    
}

+ (UIColor *)depositColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 1 green: 0.498 blue: 0 alpha: alpha];
    
}

+ (UIColor *)normalColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithWhite: 1 alpha: 0];
    
}

+ (UIColor *)SafeBoxColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.3921568627451 green: 0.45490196078431 blue: 0.52549019607843 alpha: alpha];
    
}

+ (UIColor *)IOUColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.90196078431373 green: 0.43921568627451 blue: 0.89019607843137 alpha: alpha];
    
}

+ (UIColor *)WishListColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.72941176470588 green: 0.90980392156863 blue: 0.36862745098039 alpha: alpha];
    
}

+ (UIColor *)otherColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.5921568627451 green: 0.43921568627451 blue: 0.29411764705882 alpha: alpha];
    
}

+ (UIColor *)theme1RedWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FF0000" withAlpha: alpha];
    
}

+ (UIColor *)theme1OrangeWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FF8000" withAlpha: alpha];
    
}

+ (UIColor *)theme1LemonWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FFFF00" withAlpha: alpha];
    
}

+ (UIColor *)theme1NeonGreenWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#40FF00" withAlpha: alpha];
    
}

+ (UIColor *)theme1RobbinsEggBlueWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#00FFFF" withAlpha: alpha];
    
}

+ (UIColor *)theme1SkyBlueWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#00BFFF" withAlpha: alpha];
    
}

+ (UIColor *)theme1ElectricBlueWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#0000FF" withAlpha: alpha];
    
}

+ (UIColor *)theme1PurpleWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#8000FF" withAlpha: alpha];
    
}

+ (UIColor *)theme1HotPinkWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FF00FF" withAlpha: alpha];
    
}

+ (UIColor *)theme2GuavaWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FF7373" withAlpha: alpha];
    
}

+ (UIColor *)theme2PeachWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FFB973" withAlpha: alpha];
    
}

+ (UIColor *)theme2NectarineWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FFE599" withAlpha: alpha];
    
}

+ (UIColor *)theme2KiwiWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#B9FF73" withAlpha: alpha];
    
}

+ (UIColor *)theme2PearWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#73FFB9" withAlpha: alpha];
    
}

+ (UIColor *)theme2GrapeWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#7396FF" withAlpha: alpha];
    
}

+ (UIColor *)theme2LavendarWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#BFBFFF" withAlpha: alpha];
    
}

+ (UIColor *)theme2EggplantWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#9673FF" withAlpha: alpha];
    
}

+ (UIColor *)theme2PinkLadyWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#FF99FF" withAlpha: alpha];
    
}

+ (UIColor *)theme3BloodWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#8C0000" withAlpha: alpha];
    
}

+ (UIColor *)theme3RootWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#8C4600" withAlpha: alpha];
    
}

+ (UIColor *)theme3FallWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#8C8C00" withAlpha: alpha];
    
}

+ (UIColor *)theme3MossWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#468C00" withAlpha: alpha];
    
}

+ (UIColor *)theme3OceanReefWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#008C8C" withAlpha: alpha];
    
}

+ (UIColor *)theme3NavyBlueWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#00468C" withAlpha: alpha];
    
}

+ (UIColor *)theme3MidnightBlueWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#00008C" withAlpha: alpha];
    
}

+ (UIColor *)theme3RoyalPurpleWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#330066" withAlpha: alpha];
    
}

+ (UIColor *)theme3MaroonWithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#660066" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle1WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#EEEEEE" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle2WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#DDDDDD" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle3WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#DDDDDD" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle4WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#CCCCCC" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle5WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#BBBBBB" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle6WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#888888" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle7WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#888888" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle8WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#444444" withAlpha: alpha];
    
}

+ (UIColor *)theme4GrayStyle9WithAlpha:(CGFloat)alpha {
    return [UIColor colorFromHexString: @"#000000" withAlpha: alpha];
    
}

+ (UIColor *)greenColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0 green: 0.85 blue: 0 alpha: alpha];
    
}

+ (UIColor *)lightGrayColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.918 green: 0.918 blue: 0.918 alpha: alpha];
    
}

+ (UIColor *)grayColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.784 green: 0.78 blue: 0.788 alpha: alpha];
    
}

+ (UIColor *)darkGrayColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed: 0.408 green: 0.408 blue: 0.408 alpha: alpha];
    
}

@end

@implementation NSString (STRING_)

- (NSString *)presentationString {
    NSString *string = [@"   " stringByAppendingString: self]; //Adding tab at the begging of the string
    string = [string stringByReplacingOccurrencesOfString: @"\n" withString: @"\n   "]; //adding tabs wherever a return key is found
    
    return string;
    
}

- (NSString *)stringByReformatingForSQLQuries {
    NSString *string = self;
//    string = [string stringByReplacingOccurrencesOfString: @"'" withString: @"''"];
    string = [string stringByReplacingOccurrencesOfString: @"\"" withString: @"\"\""];
    
    return string;
    
}

@end

@implementation NSDate (DATE_)

- (NSString *)stringValue:(CDDateLayout)layout {
    static NSCalendar *calendar = nil;
    if (!calendar)
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate: self];
    NSString *stringDay = [NSString stringWithFormat: @"%ld", (long)[components day]]; NSString *stringMonth = @""; NSString *stringMonthShort = @""; NSString *stringYear = [NSString stringWithFormat: @"%ld", (long)[components year]];
    if ([components month] == 1) { stringMonth = @"January"; stringMonthShort = @"Jan"; }
    else if ([components month] == 2) { stringMonth = @"February"; stringMonthShort = @"Feb"; }
    else if ([components month] == 3) { stringMonth = @"March"; stringMonthShort = @"Mar"; }
    else if ([components month] == 4) { stringMonth = @"April"; stringMonthShort = @"Apr"; }
    else if ([components month] == 5) { stringMonth = @"May"; stringMonthShort = @"May"; }
    else if ([components month] == 6) { stringMonth = @"June"; stringMonthShort = @"Jun"; }
    else if ([components month] == 7) { stringMonth = @"July"; stringMonthShort = @"Jul"; }
    else if ([components month] == 8) { stringMonth = @"August"; stringMonthShort = @"Aug"; }
    else if ([components month] == 9) { stringMonth = @"September"; stringMonthShort = @"Sep"; }
    else if ([components month] == 10) { stringMonth = @"October"; stringMonthShort = @"Oct"; }
    else if ([components month] == 11) { stringMonth = @"November"; stringMonthShort = @"Nov"; }
    else if ([components month] == 12) { stringMonth = @"December"; stringMonthShort = @"Dec"; }
    if (layout == CTCharacterDate)
        return [NSString stringWithFormat: @"%@ %@, %@", stringMonth, stringDay, stringYear];
    else if (layout == CTNumericDate)
        return [NSString stringWithFormat: @"%ld/%ld/%ld", (long)[components month], (long)[components day], (long)[components year]];
    else if (layout == CTCharacterDateMonth)
        return [NSString stringWithFormat: @"%@, %@", stringMonth, stringYear];
    else if (layout == CTCharacterDateMonthDay)
        return [NSString stringWithFormat: @"%@ %@", stringMonthShort, stringDay];
    else if (layout == CTDaysOfWeek) {
        NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"E" options:0 locale:[NSLocale currentLocale]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: formatString];
        NSString *todayString = [dateFormatter stringFromDate: self];
        return [NSString stringWithFormat: @"%@", todayString];
        
    } else if (layout == CTYear)
        return [NSString stringWithFormat: @"%ld", (long)[components year]];
    else if (layout == CTMonth)
        return stringMonthShort;
    else if (layout == CTDay)
        return [NSString stringWithFormat: @"%ld", (long)[components day]];
    else if (layout == CTHour)
        return [NSString stringWithFormat: @"%ld", (long)[components hour]];
    else if (layout == CTMinute)
        return [NSString stringWithFormat: @"%ld", (long)[components minute]];
    else if (layout == CTSecond)
        return [NSString stringWithFormat: @"%ld", (long)[components second]];
    else if (layout == CTDaysOfWeekNumbered) {
        NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"E" options:0 locale:[NSLocale currentLocale]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: formatString];
        NSString *todayString = [dateFormatter stringFromDate: self];
        return [NSString stringWithFormat: @"%@, %ld", todayString, (long)[components day]];
        
    } else if (layout == CTCharacterDateTime) {
        return [NSString stringWithFormat: @"%@, %d %2.0d:%2.0d", [self stringValue: CTCharacterDateMonthDay], (int)[components year], [components hour] > 12 ? (int)[components hour] -12 : (int)[components hour], (int)[components minute]];
    
    } else {
        NSString *stringYearClipped = [[NSString stringWithFormat: @"%ld", (long)[components year]] stringByReplacingOccurrencesOfString: [[NSString stringWithFormat: @"%ld", (long)[components year]] stringByPaddingToLength: 2 withString: @"" startingAtIndex: 0] withString: @""];
        return [NSString stringWithFormat: @"%ld/%ld/%@", (long)[components month], (long)[components day], stringYearClipped];
        
    }
    
}

@end

@implementation UILongPressGesture
@synthesize tag;

@end