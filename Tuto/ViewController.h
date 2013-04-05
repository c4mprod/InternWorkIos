//
//  ViewController.h
//  Tuto
//
//  Created by Intern on 02/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController:UIViewController<UIAlertViewDelegate, UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) IBOutlet UIButton *goButton;

- (IBAction)editBegin:(UITextField *)sender;
- (IBAction)editEnd:(UITextField *)sender;
//- (IBAction)goButton:(UIButton *)sender;

@end
