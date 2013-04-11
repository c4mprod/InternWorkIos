//
//  ViewControllerLoginTest.m
//  TutoCoreData
//
//  Created by Intern on 11/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ViewControllerLoginTest.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"

@implementation ViewControllerLoginTest
@synthesize mViewControllerLogin;
@synthesize mNavigationController;
@synthesize mManagedObjectContext;

- (void)setUp
{
    [super setUp];
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate   = [application delegate];
    UIWindow *window           = [appDelegate window];
    self.mNavigationController  = (UINavigationController *)[window rootViewController];
    self.mViewControllerLogin  = [self.mNavigationController.viewControllers objectAtIndex:0];
    self.mManagedObjectContext = appDelegate.managedObjectContext;
    
    [mViewControllerLogin.loginTextField setText:@"test"];
    [mViewControllerLogin.passwordTextField setText:@"test"];
    [mViewControllerLogin textFieldShouldReturn:mViewControllerLogin.passwordTextField];
}

- (void)tearDown
{
    [mViewControllerLogin release];
    [mNavigationController release];
    [mManagedObjectContext release];
    [super tearDown];
}

- (void)test_ViewControllerLogin_NotNil
{
    STAssertNotNil(mViewControllerLogin, @"ViewControllerLogin is not set");
}


- (void)test_ViewControllerLogin_Instance
{
    STAssertFalse([[mViewControllerLogin class] isKindOfClass:[ViewControllerLogin class]], @"ViewControllerLogin class is bad");
}

 
- (void)test_LoginTextField_NotNil
{
    STAssertNotNil(mViewControllerLogin.loginTextField, @"LoginTextField IBOutlet not connected");
}


- (void)test_PasswordTextField_NotNil
{
    STAssertNotNil(mViewControllerLogin.passwordTextField, @"PasswordTextField IBOutlet not connected");
}

- (void)test_managedObjectContext_NotNil
{
    STAssertNotNil(mManagedObjectContext, @"ManagedObjectContext is not set");
}

- (void)test_ValidateView
{
    STAssertFalse([[mNavigationController.visibleViewController class] isKindOfClass:[ViewController class]], @"ViewController not loaded");
}


@end
