//
//  ViewControllerLoginTest.h
//  TutoCoreData
//
//  Created by Intern on 11/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
@class ViewControllerLogin;
@class Users;

@interface ViewControllerLoginTest : SenTestCase

@property (retain, nonatomic) ViewControllerLogin *mViewControllerLogin;
@property (strong, nonatomic) UINavigationController *mNavigationController;
@property (retain, nonatomic) Users *mUser;
@property (retain, nonatomic) IBOutlet UITextField *loginTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) NSManagedObjectContext *mManagedObjectContext;

@end
