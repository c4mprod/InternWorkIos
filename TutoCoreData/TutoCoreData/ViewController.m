//
//  ViewController.m
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@implementation ViewController

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
    [super dealloc];
}

- (IBAction)editBegin:(UITextField *)sender
{
    [self animationEdit:-100];
}

- (IBAction)editEnd:(UITextField *)sender
{
    [self animationEdit:100];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length)
    {
        [textField resignFirstResponder];
        TableViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil request:[textField.text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        
        [self.navigationController pushViewController:tableViewController animated:true];
        [tableViewController release];
    }
    return YES;
}

@end
