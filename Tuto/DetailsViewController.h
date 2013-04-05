//
//  DetailsViewController.h
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article;

@interface DetailsViewController : UIViewController
{
    NSMutableArray *mTableData;
    int index;
}

@property (nonatomic, retain) NSMutableArray *mTableData;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil articles:(NSMutableArray*)_articles index:(int)_index;
@end
