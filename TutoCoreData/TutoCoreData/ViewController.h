//
//  ViewController.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Users;

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    Users *mVcUser;
}
@property (nonatomic, retain) Users *mVcUser;

@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)editBegin:(UITextField *)sender;
- (IBAction)editEnd:(UITextField *)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(Users *)_user;

@end
