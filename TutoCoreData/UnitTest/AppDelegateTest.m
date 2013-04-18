//
//  AppDelegateTest.m
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
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
    [_mNavigationController release];
    [_mWindow release];
    [_mAppDelegate release];
    [_mApplication release];
    _mNavigationController = nil;
    _mWindow               = nil;
    _mAppDelegate          = nil;
    _mApplication          = nil;
    [super tearDown];
    
}

- (void)test_AppDelegateTest_Application_NotNil
{
    STAssertNotNil(_mApplication, @"Application is not set");
}

- (void)test_AppDelegateTest_Application_Class
{
    STAssertFalse([[_mApplication class] isKindOfClass:[UIApplication class]], @"Application is an instance of the wrong class");
}

- (void)test_AppDelegateTest_AppDelegate_NotNil
{
    STAssertNotNil(_mAppDelegate, @"AppDelegate is not set");
}

- (void)test_AppDelegateTest_AppDelegate_Class
{
    STAssertFalse([[_mAppDelegate class] isKindOfClass:[AppDelegate class]], @"AppDelegate is an instance of the wrong class");
}

- (void)test_AppDelegateTest_Window_NotNil
{
    STAssertNotNil(_mWindow, @"Window is not set");
}

- (void)test_AppDelegateTest_Window_Class
{
    STAssertFalse([[_mWindow class] isKindOfClass:[UIWindow class]], @"Window is an instance of the wrong class");
}

- (void)test_AppDelegateTest_NavigationController_NotNil
{
    STAssertNotNil(_mNavigationController, @"NavigationController is not set");
}

- (void)test_AppDelegateTest_NavigationController_Class
{
    STAssertFalse([[_mNavigationController class] isKindOfClass:[UINavigationController class]], @"NavigationController is an instance of the wrong class");
}

@end
