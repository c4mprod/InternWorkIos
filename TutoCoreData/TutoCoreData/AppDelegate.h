//
//  AppDelegate.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewControllerLogin;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) ViewControllerLogin *viewController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
