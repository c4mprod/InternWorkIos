//
//  ViewControllerTest.m
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ViewControllerTest.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"
#import "Users.h"

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
    ViewControllerLogin *viewControllerLogin = (ViewControllerLogin *)[_mNavigationController visibleViewController];
    
    // Remplissage des champs de la vue ViewControllerLogin
    [[viewControllerLogin loginTextField] setText:NSStringFromClass([self class])];
    [[viewControllerLogin passwordTextField] setText:NSStringFromClass([self class])];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewControllerLogin
    [viewControllerLogin textFieldShouldReturn:[viewControllerLogin passwordTextField]];
    
    // Référence à la nouvelle vue visible: ViewController
    self.mViewController = (ViewController *)[_mNavigationController visibleViewController];
    [_mViewController view];
    
    // Référence aux IBOutlet présents dans la vue ViewController
    self.mSearchTextField = [_mViewController searchTextField];
}

- (void)tearDown
{
    [_mSearchTextField release];
    [_mViewController release];
    [_mNavigationController release];
    _mSearchTextField      = nil;
    _mViewController       = nil;
    _mNavigationController = nil;
    [super tearDown];
}

// Application Test
- (void)test_ViewControllerTest_ViewController_NotNil
{
    STAssertNotNil(_mViewController, @"ViewController is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Attente du chargement complet de la vue courante avant de lancer le retour au rootViewController
}

- (void)test_ViewControllerTest_ViewController_Class
{
    STAssertFalse([[_mViewController class] isKindOfClass:[ViewController class]], @"ViewController is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Attente du chargement complet de la vue courante avant de lancer le retour au rootViewController
}

- (void)test_SearchTextField_NotNil
{
    STAssertNotNil(_mSearchTextField, @"SearchTextField IBOutlet not connected");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Attente du chargement complet de la vue courante avant de lancer le retour au rootViewController
}

- (void)test_ViewControllerTest_SearchTextField_Class
{
    STAssertFalse([[_mSearchTextField class] isKindOfClass:[UITextField class]], @"SearchTextField is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Attente du chargement complet de la vue courante avant de lancer le retour au rootViewController
}

// Logic Test
- (void)test_User_NotNil
{
    STAssertNotNil([_mViewController mVcUser], @"User is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_User_Class
{
    STAssertFalse([[[_mViewController mVcUser] class] isKindOfClass:[Users class]], @"User is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

@end
