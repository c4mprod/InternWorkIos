//
//  ViewControllerLoginTest.m
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ViewControllerLoginTest.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"

@implementation ViewControllerLoginTest

- (void)setUp
{
    [super setUp];
    // Référence au rootViewController de l'application
    UIApplication *application                   = [UIApplication sharedApplication];
    AppDelegate *appDelegate                     = [application delegate];
    UIWindow *window                             = [appDelegate window];
    UINavigationController *navigationController = (UINavigationController *)[window rootViewController];
    
    // Référence à la nouvelle vue visible: ViewControllerLogin
    self.mViewControllerLogin = (ViewControllerLogin *)[navigationController visibleViewController];
    //[_mViewControllerLogin view];
    
    // Référence aux IBOutlet présents dans la vue ViewControllerLogin
    self.mLoginTextField    = [_mViewControllerLogin loginTextField];
    self.mPasswordTextField = [_mViewControllerLogin passwordTextField];
}

- (void)tearDown
{
    [_mLoginTextField release];
    [_mPasswordTextField release];
    [_mViewControllerLogin release];
    _mLoginTextField      = nil;
    _mPasswordTextField   = nil;
    _mViewControllerLogin = nil;
    [super tearDown];
}

- (void)test_ViewControllerLoginTest_ViewControllerLogin_NotNil
{
    STAssertNotNil(_mViewControllerLogin, @"ViewControllerLogin is not set");
}

- (void)test_ViewControllerLoginTest_ViewControllerLogin_Class
{
    STAssertFalse([[_mViewControllerLogin class] isKindOfClass:[ViewControllerLogin class]], @"ViewControllerLogin is an instance of the wrong class");
}

- (void)test_ViewControllerLoginTest_LoginTextField_NotNil
{
    STAssertNotNil(_mLoginTextField, @"LoginTextField IBOutlet not connected");
}

- (void)test_ViewControllerLoginTest_LoginTextField_Class
{
    STAssertFalse([[_mLoginTextField class] isKindOfClass:[UITextField class]], @"LoginTextField is an instance of the wrong class");
}

- (void)test_ViewControllerLoginTest_PasswordTextField_NotNil
{
    STAssertNotNil(_mPasswordTextField, @"PasswordTextField IBOutlet not connected");
}

- (void)test_ViewControllerLoginTest_PasswordTextField_Class
{
    STAssertFalse([[_mPasswordTextField class] isKindOfClass:[UITextField class]], @"PasswordTextField is an instance of the wrong class");
}

@end
