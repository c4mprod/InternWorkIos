//
//  ViewController.m
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "Users.h"

@implementation ViewController
@synthesize mVcUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(Users *)_user
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.mVcUser = _user;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_searchTextField release];
    [mVcUser release];
    [super dealloc];
}

- (void)animationEdit:(int)_decal
{
    _searchTextField.frame = CGRectMake(_searchTextField.frame.origin.x, _searchTextField.frame.origin.y + _decal, _searchTextField.frame.size.width, _searchTextField.frame.size.height);
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView commitAnimations];
}

- (IBAction)editBegin:(UITextField *)sender
{
    [self animationEdit:-100];
}

- (IBAction)editEnd:(UITextField *)sender
{
    [self animationEdit:100];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length != 0)
    {
        [textField resignFirstResponder];
        TableViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil request:[textField.text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] user:mVcUser];
        
        [self.navigationController pushViewController:tableViewController animated:true];
        [tableViewController release];
    }
    return YES;
}

@end
