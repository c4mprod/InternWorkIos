//
//  ViewControllerLogin.h
//  TutoCoreData
//
//  Created by Intern on 10/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

@class Users;

@interface ViewControllerLogin : UIViewController <UITextFieldDelegate, NSFetchedResultsControllerDelegate>
{
    Users *mUser;
}
@property (nonatomic, retain) Users *mUser;

@property (retain, nonatomic) IBOutlet UITextField *loginTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) NSFetchedResultsController *mFetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
