//
//  ViewControllerLogin.m
//  TutoCoreData
//
//  Created by Intern on 10/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerLogin.h"
#import "ViewController.h"
#import "Users.h"
#import "NSString+MD5.h"

@implementation ViewControllerLogin
@synthesize mUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _loginTextField.delegate    = self;
    _passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_loginTextField release];
    [_passwordTextField release];
    [self.mUser release];
    [super dealloc];
}

- (void)alertViewMessage:(NSString *)title message:(NSString *)_message;
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alertView show];
}

- (BOOL)dataCoreCreateUser
{
    self.mUser          = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    self.mUser.login    = _loginTextField.text;
    self.mUser.password = [NSString md5:_passwordTextField.text];
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error])
    {
        [self alertViewMessage:@"Error" message:@"Database error: Failed to create user"];
        return FALSE;
    }
    return TRUE;
}

- (BOOL)dataCoreUserRequest
{
    NSFetchRequest *query       = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"login = %@", _loginTextField.text];
    [query setEntity:entity];
    [query setPredicate:predicate];
    [query setFetchLimit:1];
    
    NSError *error = nil;
    if ([_managedObjectContext countForFetchRequest:query error:&error])
    {      
        self.mUser = [[_managedObjectContext executeFetchRequest:query error:&error] lastObject];
        if ([[NSString md5:self.mUser.password] isEqualToString:_passwordTextField.text])
        {
            if (![_managedObjectContext save:&error])
            {
                [self alertViewMessage:@"Error" message:@"Database error: Failed to access to user data"];
                return FALSE;
            }
            return TRUE;
        }
        [self alertViewMessage:@"Error" message:@"Wrong password"];
        return FALSE;
    }
    return [self dataCoreCreateUser];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _loginTextField)
    {
        [_passwordTextField becomeFirstResponder];
        
    }
    if (_loginTextField.text.length != 0 && _passwordTextField.text.length != 0)
    {
        if ([self dataCoreUserRequest])
        {
             ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil user:self.mUser];
             [self.navigationController pushViewController:viewController animated:true];
             [viewController release];
        }
    }
    return YES;
}

@end
