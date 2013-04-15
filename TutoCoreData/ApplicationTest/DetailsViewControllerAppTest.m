//
//  DetailsViewControllerTest.m
//  TutoCoreData
//
//  Created by Intern on 15/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "DetailsViewControllerAppTest.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"
#import "TableViewController.h"
#import "DetailsViewController.h"
#import "ImageViewManager.h"

@implementation DetailsViewControllerTest

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
    ViewController *mViewController = (ViewController *)_mNavigationController.visibleViewController;
    [mViewController view];
    
    // Remplissage des champs de la vue ViewController
    [mViewController.searchTextField setText:@"test"];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewController
    [mViewController textFieldShouldReturn:mViewController.searchTextField];
    
    // Référence à la nouvelle vue visible: TableViewController
    TableViewController *mTableViewController = (TableViewController *)_mNavigationController.visibleViewController;
    [mTableViewController view];
    
    // Simulation du touch sur la première case de la TableView
    NSInteger sectionIndex = [mTableViewController.mTableView numberOfSections] - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
    [mTableViewController tableView:mTableViewController.mTableView didSelectRowAtIndexPath:indexPath];
    
    // Référence à la nouvelle vue visible: DetailsViewController
    self.mDetailsViewController = (DetailsViewController *)_mNavigationController.visibleViewController;
    [_mDetailsViewController view];
    
    // Référence aux IBOutlet présents dans la vue ViewControllerLogin
    self.mImageView = _mDetailsViewController.imageView;
}

- (void)tearDown
{
    [_mNavigationController release];
    [_mDetailsViewController release];
    [_mImageView release];
    [super tearDown];
}

- (void)test_DetailsViewController_NotNil
{
    STAssertNotNil(_mDetailsViewController, @"DetailsViewController is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_DetailsViewController_Class
{
    STAssertFalse([[_mDetailsViewController class] isKindOfClass:[DetailsViewController class]], @"DetailsViewController is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_ImageView_NotNil
{
    STAssertNotNil(_mImageView, @"ImageView IBOutlet not connected");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_ImageView_Class
{
    STAssertFalse([[_mImageView class] isKindOfClass:[ImageViewManager class]], @"ImageView is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

@end
