//
//  DetailsViewControllerTest.h
//  TutoCoreData
//
//  Created by Intern on 16/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class DetailsViewController, ImageViewManager;

@interface DetailsViewControllerTest : SenTestCase

@property (strong, nonatomic) UINavigationController *mNavigationController;
@property (retain, nonatomic) DetailsViewController *mDetailsViewController;
@property (retain, nonatomic) IBOutlet ImageViewManager *mImageView;

@end
