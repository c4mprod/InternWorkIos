//
//  DetailViewController.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
