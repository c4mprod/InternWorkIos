//
//  ViewControllerTestLogic.m
//  TutoCoreData
//
//  Created by Intern on 18/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ViewControllerTestLogic.h"
#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"
#import "NSString+MD5.h"

@implementation ViewControllerTestLogic
static uint userNum = 0;

- (void)setUp
{
    [super setUp];
    // Référence au rootViewController de l'application
    UIApplication *application = [UIApplication sharedApplication];
    AppDelegate *appDelegate   = [application delegate];
    UIWindow *window           = [appDelegate window];
    self.mNavigationController = (UINavigationController *)[window rootViewController];
    
    // Référence à la nouvelle vue visible: ViewControllerLogin
   self.mViewControllerLogin = (ViewControllerLogin *)[_mNavigationController visibleViewController];
    
    // Référence aux IBOutlet présents dans la vue ViewControllerLogin
    self.mLoginTextField    = [_mViewControllerLogin loginTextField];
    self.mPasswordTextField = [_mViewControllerLogin passwordTextField];
    
    self.mManagedObjectContext = [_mViewControllerLogin managedObjectContext];
}

- (void)tearDown
{
    [_mLoginTextField release];
    [_mPasswordTextField release];
    [_mViewControllerLogin release];
    [_mManagedObjectContext release];
    _mLoginTextField       = nil;
    _mPasswordTextField    = nil;
    _mViewControllerLogin  = nil;
    _mManagedObjectContext = nil;
    [super tearDown];
}

- (NSString *)getUniqueUser:(int)num
{
    return [NSString stringWithFormat:@"%@_user%d", NSStringFromClass([self class]), num];
}

- (void)loginCreateUniqueUser
{
    NSString *getUniqueUser = [self getUniqueUser:userNum++];
    // Remplissage des champs de la vue ViewControllerLogin
    [_mLoginTextField setText:getUniqueUser];
    [_mPasswordTextField setText:getUniqueUser];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewControllerLogin
    [_mViewControllerLogin textFieldShouldReturn:_mPasswordTextField];
}

- (void)loginLastUser
{
    NSString *getUniqueUser = [self getUniqueUser:userNum - 1];
    // Remplissage des champs de la vue ViewControllerLogin
    [_mLoginTextField setText:getUniqueUser];
    [_mPasswordTextField setText:getUniqueUser];
    
    // Simulation du touch sur la touche "Go" du clavier de la vue ViewControllerLogin
    [_mViewControllerLogin textFieldShouldReturn:_mPasswordTextField];
}

- (void)test_ViewControllerTestLogic_User_NotNil
{
    [self loginCreateUniqueUser]; // Création d'un utilisateur unique
    ViewController *viewController = (ViewController *)[_mNavigationController visibleViewController];
    
    STAssertNotNil([viewController mVcUser], @"ViewController mVcUser is not set");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

// Teste si nouvel utilisateur bien créé dans CoraData
- (void)test_ViewControllerTestLogic_CoreData_UserCreated
{
    [self loginCreateUniqueUser]; // Création d'un utilisateur unique
    NSFetchRequest *query       = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_mManagedObjectContext];
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"login = %@ AND password = %@", [_mLoginTextField text], [NSString md5:[_mPasswordTextField text]]];
    [query setEntity:entity];
    [query setPredicate:predicate];
    [query setFetchLimit:1];
    
    STAssertTrue([_mManagedObjectContext countForFetchRequest:query error:nil] == 1, @"User is not in CoreData");
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

// Teste si utilisateur déjà existant dans CoraData n'est pas ajouter en plus dans CoreData
- (void)test_ViewControllerTestLogic_CoreData_UserExists
{
    [self loginCreateUniqueUser]; // Création d'un utilisateur unique
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
    NSFetchRequest *query       = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_mManagedObjectContext];
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"login = %@ AND password = %@", [_mLoginTextField text], [NSString md5:[_mPasswordTextField text]]];
    [query setEntity:entity];
    [query setPredicate:predicate];
    [query setFetchLimit:1];
    
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
    
    [self loginLastUser]; // Connection avec l'utilisateur qui vient d'être créé
    query     = [[[NSFetchRequest alloc] init] autorelease];
    entity    = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_mManagedObjectContext];
    predicate = [NSPredicate predicateWithFormat:@"login = %@ AND password = %@", [_mLoginTextField text], [NSString md5:[_mPasswordTextField text]]];
    [query setEntity:entity];
    [query setPredicate:predicate];
    
    NSInteger nbUser = [_mManagedObjectContext countForFetchRequest:query error:nil];
    STAssertTrue(nbUser == 1, @"%d user have the same login", nbUser);
    [_mNavigationController popToRootViewControllerAnimated:FALSE]; // Retour au rootViewController
}

@end
