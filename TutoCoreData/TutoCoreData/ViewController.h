//
//  ViewController.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)editBegin:(UITextField *)sender;
- (IBAction)editEnd:(UITextField *)sender;

@end
