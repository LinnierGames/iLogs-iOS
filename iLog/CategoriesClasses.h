//
//  CategoriesClasses.h
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (ARRAY_)

- (NSMutableDictionary *)options;

@end

@interface UIColor (CustomUIColor)

+ (UIColor *)incomeColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)expenseColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)transferColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)depositColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)normalColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)SafeBoxColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)IOUColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)WishListColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)otherColorWithAlpha:(CGFloat)alpha;

+ (UIColor *)theme1RedWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1OrangeWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1LemonWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1NeonGreenWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1RobbinsEggBlueWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1SkyBlueWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1ElectricBlueWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1PurpleWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme1HotPinkWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2GuavaWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2PeachWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2NectarineWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2KiwiWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2PearWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2GrapeWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2LavendarWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2EggplantWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme2PinkLadyWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3BloodWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3RootWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3FallWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3MossWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3OceanReefWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3NavyBlueWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3MidnightBlueWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3RoyalPurpleWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme3MaroonWithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle1WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle2WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle3WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle4WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle5WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle6WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle7WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle8WithAlpha:(CGFloat)alpha;
+ (UIColor *)theme4GrayStyle9WithAlpha:(CGFloat)alpha;

+ (UIColor *)greenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)lightGrayColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)grayColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)darkGrayColorWithAlpha:(CGFloat)alpha;

@end

typedef NS_ENUM(int, CDColorTraits) {
    CTColorNormal = 0,
    CTColorSafeBox = 1,
    CTColorIOU = 2,
    CTColorWishList = 3,
    CTColorOther = 4,
    
    /*!Theme1: 9*/
    CTColorTheme1Red = 5,
    CTColorTheme1Orange = 6,
    CTColorTheme1Lemon = 7,
    CTColorTheme1NeonGreen = 8,
    CTColorTheme1RobbinsEggBlue = 9,
    CTColorTheme1SkyBlue = 10,
    CTColorTheme1ElectricBlue = 11,
    CTColorTheme1Purple = 12,
    CTColorTheme1HotPink = 13,
    /*!Theme2: 9*/
    CTColorTheme2Guava = 14,
    CTColorTheme2Peach = 15,
    CTColorTheme2Nectarine = 16,
    CTColorTheme2Kiwi = 17,
    CTColorTheme2Pear = 18,
    CTColorTheme2Grape = 19,
    CTColorTheme2Lavendar = 20,
    CTColorTheme2Eggplant = 21,
    CTColorTheme2PinkLady = 22,
    /*!Theme3: 9*/
    CTColorTheme3Blood = 23,
    CTColorTheme3Root = 24,
    CTColorTheme3Fall = 25,
    CTColorTheme3Moss = 26,
    CTColorTheme3OceanReef = 27,
    CTColorTheme3NavyBlue = 28,
    CTColorTheme3MidnightBlue = 29,
    CTColorTheme3RoyalPurple = 30,
    CTColorTheme3Maroon = 31,
    /*!Theme4: 9*/
    CTColorTheme4GrayStyle1 = 32,
    CTColorTheme4GrayStyle2 = 33,
    CTColorTheme4GrayStyle3 = 34,
    CTColorTheme4GrayStyle4 = 35,
    CTColorTheme4GrayStyle5 = 36,
    CTColorTheme4GrayStyle6 = 37,
    CTColorTheme4GrayStyle7 = 38,
    CTColorTheme4GrayStyle8 = 39,
    CTColorTheme4GrayStyle9 = 40
    
};

static inline unsigned int NSTraitCount() {
    return (rand() % 36) +5;
    
}

static inline CDColorTraits NSColorTraitByIndex(int index) {
    switch (index) {
        case 0:
            return CTColorNormal; break;
        case 1:
            return CTColorSafeBox; break;
        case 2:
            return CTColorIOU; break;
        case 3:
            return CTColorWishList; break;
        case 4:
            return CTColorOther; break;
        case 5:
            return CTColorTheme1Red; break;
        case 6:
            return CTColorTheme1Orange; break;
        case 7:
            return CTColorTheme1Lemon; break;
        case 8:
            return CTColorTheme1NeonGreen; break;
        case 9:
            return CTColorTheme1RobbinsEggBlue; break;
        case 10:
            return CTColorTheme1SkyBlue; break;
        case 11:
            return CTColorTheme1ElectricBlue; break;
        case 12:
            return CTColorTheme1Purple; break;
        case 13:
            return CTColorTheme1HotPink; break;
        case 14:
            return CTColorTheme2Guava; break;
        case 15:
            return CTColorTheme2Peach; break;
        case 16:
            return CTColorTheme2Nectarine; break;
        case 17:
            return CTColorTheme2Kiwi; break;
        case 18:
            return CTColorTheme2Pear; break;
        case 19:
            return CTColorTheme2Grape; break;
        case 20:
            return CTColorTheme2Lavendar; break;
        case 21:
            return CTColorTheme2Eggplant; break;
        case 22:
            return CTColorTheme2PinkLady; break;
        case 23:
            return CTColorTheme3Blood; break;
        case 24:
            return CTColorTheme3Root; break;
        case 25:
            return CTColorTheme3Fall; break;
        case 26:
            return CTColorTheme3Moss; break;
        case 27:
            return CTColorTheme3OceanReef; break;
        case 28:
            return CTColorTheme3NavyBlue; break;
        case 29:
            return CTColorTheme3MidnightBlue; break;
        case 30:
            return CTColorTheme3RoyalPurple; break;
        case 31:
            return CTColorTheme3Maroon; break;
        case 32:
            return CTColorTheme4GrayStyle1; break;
        case 33:
            return CTColorTheme4GrayStyle2; break;
        case 34:
            return CTColorTheme4GrayStyle3; break;
        case 35:
            return CTColorTheme4GrayStyle4; break;
        case 36:
            return CTColorTheme4GrayStyle5; break;
        case 37:
            return CTColorTheme4GrayStyle6; break;
        case 38:
            return CTColorTheme4GrayStyle7; break;
        case 39:
            return CTColorTheme4GrayStyle8; break;
        case 40:
            return CTColorTheme4GrayStyle9; break;
        default: return CTColorNormal; break;
            
    }
    
}

static inline UIColor* NSColorByTrait(CDColorTraits trait, CGFloat alpha) {
    switch (trait) {
        case CTColorNormal:
            return [UIColor whiteColor]; break;
        case CTColorSafeBox:
            return [UIColor SafeBoxColorWithAlpha: alpha]; break;
        case CTColorIOU:
            return [UIColor IOUColorWithAlpha: alpha]; break;
        case CTColorWishList:
            return [UIColor WishListColorWithAlpha: alpha]; break;
        case CTColorOther:
            return [UIColor otherColorWithAlpha: alpha]; break;
        case CTColorTheme1Red:
            return [UIColor theme1RedWithAlpha: alpha]; break;
        case CTColorTheme1Orange:
            return [UIColor theme1OrangeWithAlpha: alpha]; break;
        case CTColorTheme1Lemon:
            return [UIColor theme1LemonWithAlpha: alpha]; break;
        case CTColorTheme1NeonGreen:
            return [UIColor theme1NeonGreenWithAlpha: alpha]; break;
        case CTColorTheme1RobbinsEggBlue:
            return [UIColor theme1RobbinsEggBlueWithAlpha: alpha]; break;
        case CTColorTheme1SkyBlue:
            return [UIColor theme1SkyBlueWithAlpha: alpha]; break;
        case CTColorTheme1ElectricBlue:
            return [UIColor theme1ElectricBlueWithAlpha: alpha]; break;
        case CTColorTheme1Purple:
            return [UIColor theme1PurpleWithAlpha: alpha]; break;
        case CTColorTheme1HotPink:
            return [UIColor theme1HotPinkWithAlpha: alpha]; break;
        case CTColorTheme2Guava:
            return [UIColor theme2GuavaWithAlpha: alpha]; break;
        case CTColorTheme2Peach:
            return [UIColor theme2PeachWithAlpha: alpha]; break;
        case CTColorTheme2Nectarine:
            return [UIColor theme2NectarineWithAlpha: alpha]; break;
        case CTColorTheme2Kiwi:
            return [UIColor theme2KiwiWithAlpha: alpha]; break;
        case CTColorTheme2Pear:
            return [UIColor theme2PearWithAlpha: alpha]; break;
        case CTColorTheme2Grape:
            return [UIColor theme2GrapeWithAlpha: alpha]; break;
        case CTColorTheme2Lavendar:
            return [UIColor theme2LavendarWithAlpha: alpha]; break;
        case CTColorTheme2Eggplant:
            return [UIColor theme2EggplantWithAlpha: alpha]; break;
        case CTColorTheme2PinkLady:
            return [UIColor theme2PinkLadyWithAlpha: alpha]; break;
        case CTColorTheme3Blood:
            return [UIColor theme3BloodWithAlpha: alpha]; break;
        case CTColorTheme3Root:
            return [UIColor theme3RootWithAlpha: alpha]; break;
        case CTColorTheme3Fall:
            return [UIColor theme3FallWithAlpha: alpha]; break;
        case CTColorTheme3Moss:
            return [UIColor theme3MossWithAlpha: alpha]; break;
        case CTColorTheme3OceanReef:
            return [UIColor theme3OceanReefWithAlpha: alpha]; break;
        case CTColorTheme3NavyBlue:
            return [UIColor theme3NavyBlueWithAlpha: alpha]; break;
        case CTColorTheme3MidnightBlue:
            return [UIColor theme3MidnightBlueWithAlpha: alpha]; break;
        case CTColorTheme3RoyalPurple:
            return [UIColor theme3RoyalPurpleWithAlpha: alpha]; break;
        case CTColorTheme3Maroon:
            return [UIColor theme3MaroonWithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle1:
            return [UIColor theme4GrayStyle1WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle2:
            return [UIColor theme4GrayStyle2WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle3:
            return [UIColor theme4GrayStyle3WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle4:
            return [UIColor theme4GrayStyle4WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle5:
            return [UIColor theme4GrayStyle5WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle6:
            return [UIColor theme4GrayStyle6WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle7:
            return [UIColor theme4GrayStyle7WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle8:
            return [UIColor theme4GrayStyle8WithAlpha: alpha]; break;
        case CTColorTheme4GrayStyle9:
            return [UIColor theme4GrayStyle9WithAlpha: alpha]; break;
        default: return [UIColor whiteColor]; break;
            
    }
    
}

static inline NSString* NSTitleByColorTrait( CDColorTraits trait) {
    switch (trait) {
        case CTColorNormal:
            return @"White"; break;
        case CTColorSafeBox:
            return @"DEPRECIATED"; break;
        case CTColorIOU:
            return @"DEPRECIATED"; break;
        case CTColorWishList:
            return @"DEPRECIATED"; break;
        case CTColorOther:
            return @"DEPRECIATED"; break;
        case CTColorTheme1Red:
            return @"Red"; break;
        case CTColorTheme1Orange:
            return @"Orange"; break;
        case CTColorTheme1Lemon:
            return @"Lemon"; break;
        case CTColorTheme1NeonGreen:
            return @"Green"; break;
        case CTColorTheme1RobbinsEggBlue:
            return @"Robbin's Egg Blue"; break;
        case CTColorTheme1SkyBlue:
            return @"Sky Blue"; break;
        case CTColorTheme1ElectricBlue:
            return @"Electric Blue"; break;
        case CTColorTheme1Purple:
            return @"Purple"; break;
        case CTColorTheme1HotPink:
            return @"Hot Pink"; break;
        case CTColorTheme2Guava:
            return @"Guava"; break;
        case CTColorTheme2Peach:
            return @"Peach"; break;
        case CTColorTheme2Nectarine:
            return @"Nectarine"; break;
        case CTColorTheme2Kiwi:
            return @"Kiwi"; break;
        case CTColorTheme2Pear:
            return @"Pear"; break;
        case CTColorTheme2Grape:
            return @"Grape"; break;
        case CTColorTheme2Lavendar:
            return @"Lavendar"; break;
        case CTColorTheme2Eggplant:
            return @"Eggplant"; break;
        case CTColorTheme2PinkLady:
            return @"Pink Lady"; break;
        case CTColorTheme3Blood:
            return @"Blood"; break;
        case CTColorTheme3Root:
            return @"Root"; break;
        case CTColorTheme3Fall:
            return @"Fall"; break;
        case CTColorTheme3Moss:
            return @"Moss"; break;
        case CTColorTheme3OceanReef:
            return @"Ocean Reef"; break;
        case CTColorTheme3NavyBlue:
            return @"Navy Blue"; break;
        case CTColorTheme3MidnightBlue:
            return @"Midnight Blue"; break;
        case CTColorTheme3RoyalPurple:
            return @"Royal Purple"; break;
        case CTColorTheme3Maroon:
            return @"Maroon"; break;
        case CTColorTheme4GrayStyle1:
            return @"Gray-Scale 01"; break;
        case CTColorTheme4GrayStyle2:
            return @"Gray-Scale 02"; break;
        case CTColorTheme4GrayStyle3:
            return @"Gray-Scale 03"; break;
        case CTColorTheme4GrayStyle4:
            return @"Gray-Scale 04"; break;
        case CTColorTheme4GrayStyle5:
            return @"Gray-Scale 05"; break;
        case CTColorTheme4GrayStyle6:
            return @"Gray-Scale 06"; break;
        case CTColorTheme4GrayStyle7:
            return @"Gray-Scale 07"; break;
        case CTColorTheme4GrayStyle8:
            return @"Gray-Scale 08"; break;
        case CTColorTheme4GrayStyle9:
            return @"Gray-Scale 09"; break;
        default: return @"Not Found"; break;
            
    }
    
}

static inline NSArray* NSColorArrayByTheme() {
    return [NSArray arrayWithObjects:
            /*Theme1*/
            @[
              @(CTColorNormal),
              @(CTColorTheme1Red),
              @(CTColorTheme1Orange),
              @(CTColorTheme1Lemon),
              @(CTColorTheme1NeonGreen),
              @(CTColorTheme1RobbinsEggBlue),
              @(CTColorTheme1SkyBlue),
              @(CTColorTheme1ElectricBlue),
              @(CTColorTheme1Purple),
              @(CTColorTheme1HotPink)
              ],
            /*Theme2*/
            @[
              @(CTColorNormal),
              @(CTColorTheme2Guava),
              @(CTColorTheme2Peach),
              @(CTColorTheme2Nectarine),
              @(CTColorTheme2Kiwi),
              @(CTColorTheme2Pear),
              @(CTColorTheme2Grape),
              @(CTColorTheme2Lavendar),
              @(CTColorTheme2Eggplant),
              @(CTColorTheme2PinkLady)
              ],
            /*Theme3*/
            @[
              @(CTColorNormal),
              @(CTColorTheme3Blood),
              @(CTColorTheme3Root),
              @(CTColorTheme3Fall),
              @(CTColorTheme3Moss),
              @(CTColorTheme3OceanReef),
              @(CTColorTheme3NavyBlue),
              @(CTColorTheme3MidnightBlue),
              @(CTColorTheme3RoyalPurple),
              @(CTColorTheme3Maroon)
              ],
            /*Theme4*/
            @[
              @(CTColorNormal),
              @(CTColorTheme4GrayStyle1),
              @(CTColorTheme4GrayStyle2),
              @(CTColorTheme4GrayStyle3),
              @(CTColorTheme4GrayStyle4),
              @(CTColorTheme4GrayStyle5),
              @(CTColorTheme4GrayStyle6),
              @(CTColorTheme4GrayStyle7),
              @(CTColorTheme4GrayStyle8),
              @(CTColorTheme4GrayStyle9)
              ],
            /*All*/
            @[
              @(CTColorNormal),
              @(CTColorTheme1Red),
              @(CTColorTheme1Orange),
              @(CTColorTheme1Lemon),
              @(CTColorTheme1NeonGreen),
              @(CTColorTheme1RobbinsEggBlue),
              @(CTColorTheme1SkyBlue),
              @(CTColorTheme1ElectricBlue),
              @(CTColorTheme1Purple),
              @(CTColorTheme1HotPink),
              @(CTColorTheme2Guava),
              @(CTColorTheme2Peach),
              @(CTColorTheme2Nectarine),
              @(CTColorTheme2Kiwi),
              @(CTColorTheme2Pear),
              @(CTColorTheme2Grape),
              @(CTColorTheme2Lavendar),
              @(CTColorTheme2Eggplant),
              @(CTColorTheme2PinkLady),
              @(CTColorTheme3Blood),
              @(CTColorTheme3Root),
              @(CTColorTheme3Fall),
              @(CTColorTheme3Moss),
              @(CTColorTheme3OceanReef),
              @(CTColorTheme3NavyBlue),
              @(CTColorTheme3MidnightBlue),
              @(CTColorTheme3RoyalPurple),
              @(CTColorTheme3Maroon),
              @(CTColorTheme4GrayStyle1),
              @(CTColorTheme4GrayStyle2),
              @(CTColorTheme4GrayStyle3),
              @(CTColorTheme4GrayStyle4),
              @(CTColorTheme4GrayStyle5),
              @(CTColorTheme4GrayStyle6),
              @(CTColorTheme4GrayStyle7),
              @(CTColorTheme4GrayStyle8),
              @(CTColorTheme4GrayStyle9)
              ], nil
            ];
    
}

@interface NSString (STRING_)

- (NSString *)reformatForSQLQuries;

@end