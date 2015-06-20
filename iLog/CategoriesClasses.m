//
//  CategoriesClasses.m
//  iLog
//
//  Created by Erick Sanchez on 6/19/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "CategoriesClasses.h"

@implementation NSArray (ARRAY_)

- (NSMutableDictionary *)options {
    return (NSMutableDictionary *)[self lastObject];
    
}

@end

