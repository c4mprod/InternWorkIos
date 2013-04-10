//
//  DetailsViewController.m
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Articles.h"
#import "ImageManager.h"

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self.imageView release];
    [self.mTableData release];
    [super dealloc];
}

- (void)loadImage
{
    Articles *article    = [self.mTableData objectAtIndex:index];
    self.title           = article.title;
    self.imageView.image = [[ImageManager sharedImageManager] getImageNamed:article.urlImage withDelegate:self.imageView];
}

- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer
{
    if (index < self.mTableData.count - 1)
    {
        index++;
        [self loadImage];
    }
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer
{
    if (index > 0)
    {
        index--;
        [self loadImage];
    }
}

@end
