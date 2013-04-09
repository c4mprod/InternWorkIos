//
//  TableViewController.h
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ArticleRequest.h"
#import "Articles.h"

@interface TableViewController:UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSString *mSearchRequest;
    NSMutableArray *mTableData;
    int mResultPerPage; // integer from 1–8 indicating the number of results to return per page.
    int mStartIndex;
    BOOL mResultEnd;
    NSFetchedResultsController *mFetchedResultsController;
    NSManagedObjectContext *mContext;
}

@property (nonatomic, retain) NSString *mSearchRequest;
@property (nonatomic, retain) NSMutableArray *mTableData;
@property (nonatomic, retain) IBOutlet UITableView *mTableView;
@property (nonatomic, retain) NSFetchedResultsController *mFetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *mContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil request:(NSString *)_request fetchedResultsController:(NSFetchedResultsController *)_fetchedResultsController;

@end
