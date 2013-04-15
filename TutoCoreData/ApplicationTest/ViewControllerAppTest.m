//
//  ViewController.m
//  TutoCoreData
//
//  Created by Intern on 12/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ViewControllerAppTest.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"

@implementation ViewControllerTest

- (void)setUp
{
    [super setUp];
    // Référence au rootViewController de l'application 
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate   = [application delegate];
    UIWindow *window           = [appDelegate window];
    self.mNavigationController = (UINavigationController *)[window rootViewController];
    
    // Référence à la nouvelle vue visible: ViewControllerLogin
    ViewControllerLogin *viewControllerLogin = (ViewControllerLogin *)_mNavigationController.visibleViewController;
    [viewControllerLogin view];
    
    // Remplissage des champs de la vue ViewControllerLogin
    [viewControllerLogin.loginTextField setText:@"test"];
    [viewControllerLogin.passwordTextField setText:@"test"];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewControllerLogin
    [viewControllerLogin textFieldShouldReturn:viewControllerLogin.passwordTextField];
    
    // Référence à la nouvelle vue visible: ViewController
    self.mViewController = (ViewController *)_mNavigationController.visibleViewController;
    [_mViewController view];
    
    // Référence aux IBOutlet présents dans la vue ViewController
    self.mSearchTextField = _mViewController.searchTextField;
}

- (void)tearDown
{
    [_mNavigationController release];
    [_mViewController release];
    [_mSearchTextField release];
    [super tearDown];
}

- (void)test_ViewController_NotNil
{
    STAssertNotNil(_mViewController, @"ViewController is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_ViewController_Class
{
    STAssertFalse([[_mViewController class] isKindOfClass:[ViewController class]], @"ViewController is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_SearchTextField_NotNil
{
    STAssertNotNil(_mSearchTextField, @"SearchTextField IBOutlet not connected");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_SearchTextField_Class
{
    STAssertFalse([[_mSearchTextField class] isKindOfClass:[UITextField class]], @"SearchTextField is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

@end
