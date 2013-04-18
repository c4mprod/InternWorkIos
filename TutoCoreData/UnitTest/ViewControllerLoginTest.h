//
//  ViewControllerLoginTest.h
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class AppDelegate, ViewControllerLogin;

@interface ViewControllerLoginTest : SenTestCase

@property (retain, nonatomic) ViewControllerLogin *mViewControllerLogin;
@property (retain, nonatomic) IBOutlet UITextField *mLoginTextField;
@property (retain, nonatomic) IBOutlet UITextField *mPasswordTextField;

@end
