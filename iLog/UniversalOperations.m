//
//  UniversalOperations.m
//  iLog
//
//  Created by Erick Sanchez on 6/15/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "UniversalOperations.h"

@implementation UniversalVariables

+ (UniversalVariables *)globalVariables {
    static UniversalVariables *globalVariables = nil;
    if (!globalVariables)
        globalVariables = [UniversalVariables new];
    return globalVariables;
    
}

- (id)init {
    if (!(self = [super init])) return nil;
    return self;
    
}

@end

@implementation UniversalOperations

@end
