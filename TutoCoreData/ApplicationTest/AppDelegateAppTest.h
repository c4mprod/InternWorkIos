//
//  ApplicationTest.h
//  ApplicationTest
//
//  Created by Intern on 11/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class AppDelegate, ViewControllerLogin;

@interface AppDelegateTest : SenTestCase

@property (strong, nonatomic) UIApplication *mApplication;
@property (strong, nonatomic) AppDelegate *mAppDelegate;
@property (strong, nonatomic) UIWindow *mWindow;
@property (strong, nonatomic) UINavigationController *mNavigationController;

@end
