//
//  ViewControllerTest.h
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class AppDelegate, ViewController;

@interface ViewControllerTest : SenTestCase

@property (strong, nonatomic) UINavigationController *mNavigationController;
@property (strong, nonatomic) ViewController *mViewController;
@property (retain, nonatomic) IBOutlet UITextField *mSearchTextField;

@end
