//
//  ViewControllerTestLogic.h
//  TutoCoreData
//
//  Created by Intern on 18/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class AppDelegate, ViewControllerLogin, ViewController;

@interface ViewControllerTestLogic : SenTestCase

@property (strong, nonatomic) UINavigationController *mNavigationController;
@property (retain, nonatomic) ViewControllerLogin *mViewControllerLogin;
@property (retain, nonatomic) IBOutlet UITextField *mLoginTextField;
@property (retain, nonatomic) IBOutlet UITextField *mPasswordTextField;
@property (strong, nonatomic) NSManagedObjectContext *mManagedObjectContext;

@end
