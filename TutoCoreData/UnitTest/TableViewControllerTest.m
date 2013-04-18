//
//  TableViewControllerTest.m
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "TableViewControllerTest.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"
#import "TableViewController.h"
#import "Users.h"

@implementation TableViewControllerTest
static uint searchNum = 0;

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
}

- (void)tearDown
{
    [_mTableViewController release];
    [_mViewController release];
    [_mNavigationController release];
    _mTableViewController  = nil;
    _mViewController       = nil;
    _mNavigationController = nil;
    [super tearDown];
}

-(NSString *)generateUniqueSearch:(BOOL)searchHaveResults
{
    NSString *returnValue = nil;
    if (searchHaveResults == TRUE)
    {
        returnValue = [NSString stringWithFormat:@"%d", searchNum++];
    }
    else
    {
        returnValue = [NSString stringWithFormat:@"*@qhql%d", searchNum++];
    }
    return returnValue;
}

- (void)loadTableView:(BOOL)searchHaveResults
{
    // Remplissage des champs de la vue ViewController
    [[_mViewController searchTextField] setText:[self generateUniqueSearch:searchHaveResults]];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewController
    [_mViewController textFieldShouldReturn:[_mViewController searchTextField]];
    
    // Référence à la nouvelle vue visible: TableViewController
    self.mTableViewController = (TableViewController *)[[_mNavigationController viewControllers] lastObject];
    [_mTableViewController view];
    
    // Référence aux IBOutlet présents dans la vue TableViewController
    self.mTableView = [_mTableViewController mTableView];
}

- (void)test_TableViewControllerTest_TableViewController_NotNil
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    STAssertNotNil(_mTableViewController, @"TableViewController is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TableViewController_Class
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    STAssertFalse([[_mTableViewController class] isKindOfClass:[TableViewController class]], @"TableViewController is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
   
}

- (void)test_TableViewControllerTest_TableView_NotNil
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    STAssertNotNil(_mTableView, @"TableView IBOutlet not connected");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TableView_Class
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    STAssertFalse([[_mTableView class] isKindOfClass:[UITableView class]], @"TableView is an instance of the wrong class");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TaleView_NumberOfSections
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    NSInteger numberOfSections = [_mTableView numberOfSections];
    STAssertTrue(numberOfSections == 1, @"TableView number of section should be 1 but is %d", numberOfSections);
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TableView_CellNumber_0
{
    [self loadTableView:FALSE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête ne renvoie pas de résultats
    NSInteger numberOfRowsInSection = [_mTableView numberOfRowsInSection:[_mTableView numberOfSections] - 1];
    STAssertTrue(numberOfRowsInSection == 0, @"TableView number of row in section should be 0 but is %d", numberOfRowsInSection);
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TableView_CellNumber_9
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    NSInteger numberOfRowsInSection = [_mTableView numberOfRowsInSection:[_mTableView numberOfSections] - 1];
    STAssertTrue(numberOfRowsInSection == 9, @"TableView number of row in section should be 9 but is %d", numberOfRowsInSection); // +1 pour la cellule "Load more results..."
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TableView_LastCell_LoadMore
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    NSInteger sectionIndex    = [_mTableView numberOfSections] - 1;
    NSInteger lastCellIndex   = [_mTableView numberOfRowsInSection:sectionIndex] - 1;
    NSIndexPath *pathLastCell = [NSIndexPath indexPathForRow:lastCellIndex inSection:sectionIndex];
    
    STAssertTrue([[[[_mTableView cellForRowAtIndexPath:pathLastCell] textLabel] text] isEqualToString:@"Load more results..."], @"TableView last cell text should be \"Load more results...\"");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

- (void)test_TableViewControllerTest_TableView_LoadMore
{
    [self loadTableView:TRUE]; // Chargement des résultats d'une requête unique Google Image dans la tableView. La requête renvoie des résultats. Les résultats sont renvoyés par paquet de 8
    NSInteger sectionIndex  = [_mTableView numberOfSections] - 1;
    NSInteger lastCellIndex = [_mTableView numberOfRowsInSection:sectionIndex] - 1;
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:lastCellIndex inSection:sectionIndex];
    
    // Simulation du touch sur la case "Load more results..." de la TableView => effectue un requête Google Image pour obtenir un nouveau paquet de 8 résultats
    [_mTableViewController tableView:_mTableView didSelectRowAtIndexPath:indexPath];
    
    STAssertTrue([_mTableView numberOfRowsInSection:sectionIndex] == 17, @"TableView number of row in section should be 17 but is %d", [_mTableView numberOfRowsInSection:sectionIndex]); // 8 résultats + 8 résultats du nouveau paquet + 1 pour la cellule "Load more results..."
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

@end
