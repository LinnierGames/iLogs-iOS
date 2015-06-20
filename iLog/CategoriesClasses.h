//
//  CategoriesClasses.h
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ARRAY_)

- (NSMutableDictionary *)options;

@end

@interface NSString (STRING_)

- (NSString *)reformatForSQLQuries;

@end