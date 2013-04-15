//
//  TableViewController.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArticleRequest, Articles, Users;

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSString *mSearchRequest;
    Users *mUser;
    int mResultPerPage; // integer from 1–8 indicating the number of results to return per page.
    ArticleRequest *mArticleRequest;
    NSMutableArray *mTableArticles;
}
@property (retain, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic, retain) Users *mUser;
@property (nonatomic, retain) NSString *mSearchRequest;
@property (nonatomic, retain) ArticleRequest *mArticleRequest;
@property (nonatomic, retain) NSMutableArray *mTableArticles;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil request:(NSString *)_request user:(Users *)_user;

@end
