//
//  ViewController.m
//  Tuto
//
//  Created by Intern on 02/04/13.
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
    [_goButton release];
    [super dealloc];
}

- (CGRect)frameCGRectMake:(CGRect)_frame decal:(int)_decal
{
    return CGRectMake(_frame.origin.x, _frame.origin.y + _decal, _frame.size.width, _frame.size.height);
}

- (void)animationEdit:(int)_decal
{
    _searchTextField.frame = [self frameCGRectMake:_searchTextField.frame decal:_decal];
    _goButton.frame        = [self frameCGRectMake:_goButton.frame decal:_decal];
          
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
    if (textField.text.length)
    {
        [textField resignFirstResponder];
        TableViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil request:[textField.text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        [self.navigationController pushViewController:tableViewController animated:true];
        [tableViewController release];
    }
    return YES;
}

/*
- (IBAction)goButton:(UIButton *)sender
{
    if (_searchTextField.text.length)
    {
        [_searchTextField resignFirstResponder];
        TableViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil request:[_searchTextField.text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        [self.navigationController pushViewController:tableViewController animated:true];
        [tableViewController release];
    }
}
*/
@end
