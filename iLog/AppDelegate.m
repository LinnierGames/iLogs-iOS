//
//  AppDelegate.m
//  iLog
//
//  Created by Erick Sanchez on 6/14/15.
//  Copyright (c) 2015 Erick Sanchez. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () {
    NSTimer *longTapDismissTimer;
    NSTimeInterval longTapTimer;
    CGPoint touch;
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint location = [[[event allTouches] anyObject] locationInView: [self window]];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(statusBarFrame, location) && [[[UniversalVariables globalVariables] viewController] isEqual: [[UniversalVariables globalVariables] currentView]]) {
        if ([longTapDismissTimer isValid])
            [longTapDismissTimer invalidate];
        longTapTimer = 0;
        touch = location;
        longTapDismissTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector: @selector( beganTap) userInfo: nil repeats: YES];
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    touch = [[[event allTouches] anyObject] locationInView: [self window]];
    
}

- (void)beganTap {
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(statusBarFrame, touch) && [[[UniversalVariables globalVariables] viewController] isEqual: [[UniversalVariables globalVariables] currentView]])
        longTapTimer += 0.1;
    if (longTapTimer >= 0.75) {
        [self statusBarTouchedAction];
        [self touchesEnded: nil withEvent: nil];
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    longTapTimer = 0;
    [longTapDismissTimer invalidate];
    
}

- (void)statusBarTouchedAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:kStatusBarTappedNotification
                                                            object:nil];
    
}

@end
