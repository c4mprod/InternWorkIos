//
//  TableViewControllerTest.m
//  TutoCoreData
//
//  Created by Intern on 15/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "TableViewControllerTest.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"
#import "TableViewController.h"

@implementation TableViewControllerTest

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
}

- (void)tearDown
{
    [_mNavigationController release];
    [_mViewController release];
    [_mTableViewController release];
    [super tearDown];
}

- (void)loadTableView:(NSString *)searchText
{
    // Remplissage des champs de la vue ViewController
    [_mViewController.searchTextField setText:searchText];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewController
    [_mViewController textFieldShouldReturn:_mViewController.searchTextField];
    
    // Référence à la nouvelle vue visible: TableViewController
    self.mTableViewController = (TableViewController *)_mNavigationController.visibleViewController;
    [_mTableViewController view];
    
    // Référence aux IBOutlet présents dans la vue TableViewController
    self.mTableView = _mTableViewController.mTableView;
}

- (void)test_TableViewController_NotNil
{
    [self loadTableView:@"test"];
    STAssertNotNil(_mTableViewController, @"TableViewController is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableViewController_Class
{
    [self loadTableView:@"test"];
    STAssertFalse([[_mTableViewController class] isKindOfClass:[TableViewController class]], @"TableViewController is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableView_NotNil
{
    [self loadTableView:@"test"];
    STAssertNotNil(_mTableView, @"TableView IBOutlet not connected");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableView_Class
{
    [self loadTableView:@"test"];
    STAssertFalse([[_mTableView class] isKindOfClass:[UITableView class]], @"TableView is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TaleView_NumberOfSections
{
    [self loadTableView:@"test"];
    STAssertTrue([_mTableView numberOfSections] == 1, @"TableView could be have exactly one section");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableView_CellNumber_0
{
    [self loadTableView:@"*@#"]; // Recherche qui ne renvoie aucun résultats
    STAssertTrue([_mTableView numberOfRowsInSection:([_mTableView numberOfSections] - 1)] == 0, @"TableView could be have exactly 0 cell");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableView_CellNumber_9
{
    [self loadTableView:@"test"]; // Recherche qui renvoie des résultats (la requête google les renvoie par paquet de 8)
    STAssertTrue([_mTableView numberOfRowsInSection:[_mTableView numberOfSections] - 1] == 9, @"TableView could be have exactly 9 cell"); // +1 pour la cellule "Load more results..."
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableView_LastCell_LoadMore
{
    [self loadTableView:@"test"];
    NSInteger sectionIndex    = [_mTableView numberOfSections] - 1;
    NSInteger lastCellIndex   = [_mTableView numberOfRowsInSection:sectionIndex] - 1;
    NSIndexPath *pathLastCell = [NSIndexPath indexPathForRow:lastCellIndex inSection:sectionIndex];
    
    STAssertTrue([[[[_mTableView cellForRowAtIndexPath:pathLastCell] textLabel] text] isEqualToString:@"Load more results..."], @"TableView could be have \"Load more results...\" last cell");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}

- (void)test_TableView_LoadMore
{
    [self loadTableView:@"test"];
    NSInteger sectionIndex  = [_mTableView numberOfSections] - 1;
    NSInteger lastCellIndex = [_mTableView numberOfRowsInSection:sectionIndex] - 1;
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:lastCellIndex inSection:sectionIndex];
    
    // Simulation du touch sur la case "Load more results..." de la TableView
    [_mTableViewController tableView:_mTableView didSelectRowAtIndexPath:indexPath];
    
    STAssertTrue([_mTableView numberOfRowsInSection:sectionIndex] == 17, @"TableView could be have exactly 17 cell");
    [_mNavigationController popToRootViewControllerAnimated:FALSE];
}
 
@end
