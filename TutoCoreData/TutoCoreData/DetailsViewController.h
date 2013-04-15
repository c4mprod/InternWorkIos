//
//  DetailsViewController.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageViewManager;

@interface DetailsViewController : UIViewController
{
    NSMutableArray *mTableData;
    int index;
}
@property (retain, nonatomic) IBOutlet ImageViewManager *imageView;
@property (retain, nonatomic) NSMutableArray *mTableData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil articles:(NSMutableArray*)_articles index:(int)_index;

@end
