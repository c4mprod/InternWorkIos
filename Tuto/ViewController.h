//
//  ViewController.h
//  Tuto
//
//  Created by Intern on 02/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController:UIViewController<UIAlertViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) IBOutlet UIButton *goButton;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)editBegin:(UITextField *)sender;
- (IBAction)editEnd:(UITextField *)sender;

@end
