//
//  DetailsViewController.m
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <AFNetworking.h>
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Article.h"

@implementation DetailsViewController
@synthesize mTableData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil articles:(NSMutableArray *)_articles index:(int)_index;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.mTableData = _articles;
        index           = _index;
    }
    return self;
}

- (void)loadImage
{
    Article *article = [mTableData objectAtIndex:index];
    self.title       = article.mTitle;
    NSURL *urlImage  = [NSURL URLWithString:article.mUrlImage];
    [_imageView setImageWithURL:urlImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadImage];

    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeLeft:)] autorelease];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeRight:)] autorelease];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
}

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    if (index < self.mTableData.count - 1)
    {
        index++;
        [self loadImage];
    }
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    if (index > 0)
    {
        index--;
        [self loadImage];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageView release];
    [mTableData release];
    [super dealloc];
}
@end
