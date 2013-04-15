//
//  ApplicationTest.m
//  ApplicationTest
//
//  Created by Intern on 11/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "AppDelegateTest.h"
#import "AppDelegate.h"

@implementation AppDelegateTest

- (void)setUp
{
    [super setUp];
    // Référence au rootViewController de l'application 
    self.mApplication          = [UIApplication sharedApplication];
    self.mAppDelegate          = [_mApplication delegate];
    self.mWindow               = [_mAppDelegate window];
    self.mNavigationController = (UINavigationController *)[_mWindow rootViewController];
}

- (void)tearDown
{
    [_mApplication release];
    [_mAppDelegate release];
    [_mWindow release];
    [_mNavigationController release];
    [super tearDown];
    
}

- (void)test_Application_NotNil
{
    STAssertNotNil(_mApplication, @"Application is not set");
}

- (void)test_Application_Class
{
    STAssertFalse([[_mApplication class] isKindOfClass:[UIApplication class]], @"Application is an instance of the wrong class");
}

- (void)test_AppDelegate_NotNil
{
    STAssertNotNil(_mAppDelegate, @"AppDelegate is not set");
}

- (void)test_AppDelegate_Class
{
    STAssertFalse([[_mAppDelegate class] isKindOfClass:[AppDelegate class]], @"AppDelegate is an instance of the wrong class");
}

- (void)test_Window_NotNil
{
    STAssertNotNil(_mWindow, @"Window is not set");
}

- (void)test_Window_Class
{
    STAssertFalse([[_mWindow class] isKindOfClass:[UIWindow class]], @"Window is an instance of the wrong class");
}

- (void)test_NavigationController_NotNil
{
    STAssertNotNil(_mNavigationController, @"NavigationController is not set");
}

- (void)test_NavigationController_Class
{
    STAssertFalse([[_mNavigationController class] isKindOfClass:[UINavigationController class]], @"NavigationController is an instance of the wrong class");
}

@end
