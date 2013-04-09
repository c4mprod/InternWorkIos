//
//  TableViewController.m
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <AFNetworking.h>
#import "TableViewController.h"
#import "DetailsViewController.h"
#import "Articles.h"

@implementation TableViewController

@synthesize mSearchRequest;
@synthesize mTableData;
@synthesize mFetchedResultsController;
@synthesize mContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil request:(NSString *)_request fetchedResultsController:(NSFetchedResultsController *)_fetchedResultsController;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.mSearchRequest            = _request;
        mResultPerPage                 = 8;
        mResultEnd                     = FALSE;
        self.mFetchedResultsController = _fetchedResultsController;
        self.mContext                  = [mFetchedResultsController managedObjectContext];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mTableData = [NSMutableArray array];
    [self getImageViaJSON];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [UITableView release];
    [self.mSearchRequest release];
    [self.mTableData release];
    [self.mFetchedResultsController release];
    [self.mContext release];
    [super dealloc];
}

- (void)dataCoreInsertNewRequest
{
    NSFetchRequest *query       = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Request" inManagedObjectContext:self.mContext];
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"value = %@", self.mSearchRequest];
    [query setEntity:entity];
    [query setPredicate:predicate];
    [query setFetchLimit:1];
    
    NSError *error                 = nil;
    ArticleRequest *articleRequest = nil;
    if ([self.mContext countForFetchRequest:query error:&error])
    {
         articleRequest = [[self.mContext executeFetchRequest:query error:&error] lastObject];
    }
    else
    {
        articleRequest = [NSEntityDescription insertNewObjectForEntityForName:@"Request" inManagedObjectContext:mContext];
        articleRequest = [[ArticleRequest alloc] initWithIndex:0 value:self.mSearchRequest finish:FALSE];
        
        
    }

    
    if (![self.mContext save:&error])
    {
        abort();
        [self alertViewMessage:@"Error" message:@"Database error"];
    }
    
    
    BOOL *finish    = [results valueForKey:@"finish"];
    int64_t *index = [results valueForKey:@"index"];
    
}

- (void)alertViewMessage:(NSString *)title message:(NSString *)_message
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getImageViaJSON
{   
    UIAlertView *alertView           = [[[UIAlertView alloc] initWithTitle:@"Loading..." message:@"\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
    UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    spinner.center                   = CGPointMake(139.5, 75.5);
    [alertView addSubview:spinner];
    [spinner startAnimating];
    [alertView show];
    
    NSString *urlString      = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=%d&start=%d&q=", mResultPerPage, mStartIndex];
    NSMutableString *baseUrl = [NSMutableString stringWithString:urlString];
    [baseUrl appendString:self.mSearchRequest];
    
    NSURL *url                        = [NSURL URLWithString:baseUrl];
    NSURLRequest *request             = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        if ([[JSON valueForKey:@"responseStatus"] intValue] == 400)
        {
            mResultEnd = TRUE;
            [self.mTableView reloadData];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        else
        {
            NSArray *results = [JSON valueForKeyPath:@"responseData.results"];
            if (!results || !results.count)
            {
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                [self alertViewMessage:@"Information" message:@"No result found"];
            }
            else
            {
                for (NSDictionary *lArticleDic in results)
                {
                    Article *lArticle = [[Article alloc] initWithDictionary:lArticleDic];
                    [self.mTableData addObject: lArticle];
                    [lArticle release];
                }

                if (!self.mTableData || !self.mTableData.count)
                {
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                    [self alertViewMessage:@"Information" message:@"No result found"];
                }
                else
                {
                    [self.mTableView reloadData];
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                }
            }
        }
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"JSON Request failed" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: nil] autorelease];
        [alert show];
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [operation start];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.mTableData.count)
    {
        if (indexPath.row < self.mTableData.count)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Article"] autorelease];
            }
            Article *article    = [self.mTableData objectAtIndex:indexPath.row];
            cell.textLabel.text = article.mTitle;
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (!mResultEnd)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"LoadMore"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoadMore"] autorelease];
            }
            cell.textLabel.text          = @"Load more results...";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor     = [UIColor grayColor];
            cell.textLabel.font          = [UIFont boldSystemFontOfSize:14];
            
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.mTableData.count)
    {
        return mResultEnd ? self.mTableData.count : self.mTableData.count + 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.mTableData.count)
    {
        mStartIndex += mResultPerPage;
        [self getImageViaJSON];
    }
    else
    {
        DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil articles:self.mTableData index:indexPath.row];
        [self.navigationController pushViewController:detailsViewController animated:true];
        [detailsViewController release];
    }
}

@end
