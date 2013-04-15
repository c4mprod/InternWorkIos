//
//  TableViewControllerTest.h
//  TutoCoreData
//
//  Created by Intern on 15/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class ViewController, TableViewController;

@interface TableViewControllerTest : SenTestCase

@property (strong, nonatomic) UINavigationController *mNavigationController;
@property (strong, nonatomic) ViewController *mViewController;
@property (retain, nonatomic) TableViewController *mTableViewController;
@property (retain, nonatomic) IBOutlet UITableView *mTableView;

@end
