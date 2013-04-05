//
//  TableViewController.h
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController:UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSString *mSearchRequest;
    NSMutableArray *mTableData;
    int mResultPerPage; // integer from 1–8 indicating the number of results to return per page.
    int mStartIndex;
    BOOL mResultEnd;
}

@property (nonatomic, retain) NSString *mSearchRequest;
@property (nonatomic, retain) NSMutableArray *mTableData;
@property (nonatomic, retain) IBOutlet UITableView *mTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil request:(NSString *)_request;

@end
