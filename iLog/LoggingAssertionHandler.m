//
//  LoggingAssertionHandler.m
//  iLog
//
//  Created by Erick Sanchez on 3/2/16.
//  Copyright © 2016 Erick Sanchez. All rights reserved.
//

#import "LoggingAssertionHandler.h"

@implementation LoggingAssertionHandler

- (void)handleFailureInMethod:(SEL)selector object:(id)object file:(NSString *)fileName lineNumber:(NSInteger)line description:(NSString *)format, ... {
    NSException *exception = [NSException exceptionWithName: NSInternalInconsistencyException reason: format userInfo: NULL];
    [UniversalOperations reportNewCrashReport: exception withAssertion: [NSAssertion assertionWithSelector: selector object: object file: fileName lineNumber: line description: format, nil]];
    [exception raise];
}

- (void)handleFailureInFunction:(NSString *)functionName file:(NSString *)fileName lineNumber:(NSInteger)line description:(NSString *)format, ... {
    NSLog(@"NSCAssert Failure: Function (%@) in %@ #%li", functionName, fileName, (long)line);
    [[NSException exceptionWithName: NSInternalInconsistencyException reason: format userInfo: NULL] raise];
}

@end
