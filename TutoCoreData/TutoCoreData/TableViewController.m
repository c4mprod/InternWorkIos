//
//  TableViewController.m
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <AFNetworking.h>
#import "AppDelegate.h"
#import "TableViewController.h"
#import "DetailsViewController.h"
#import "ArticleRequest.h"
#import "Articles.h"
#import "Users.h"

@implementation TableViewController
@synthesize mSearchRequest;
@synthesize mArticleRequest;
@synthesize mTableArticles;
@synthesize mUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil request:(NSString *)_request user:(Users *)_user
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.mSearchRequest       = _request;
        self.mUser                = _user;
        mResultPerPage            = 8;
        self.mArticleRequest      = nil;
        AppDelegate *appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mTableArticles = [NSMutableArray array];
    [self dataCoreArticleRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mTableView release];
    [self.mUser release];
    [self.mSearchRequest release];
    [self.mTableArticles release];
    [_managedObjectContext release];
    [super dealloc];
}

- (void)alertViewMessage:(NSString *)title message:(NSString *)_message goBack:(BOOL)_goBack;
{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alertView show];
    if (_goBack)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dataCoreArticleRequest
{
    NSFetchRequest *query       = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ArticleRequest" inManagedObjectContext:_managedObjectContext];
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"user = %@ AND value = %@", self.mUser, self.mSearchRequest];
    [query setEntity:entity];
    [query setPredicate:predicate];
    [query setFetchLimit:1];
    
    NSError *error = nil;
    if ([_managedObjectContext countForFetchRequest:query error:&error])
    {
        self.mArticleRequest = [[_managedObjectContext executeFetchRequest:query error:&error] lastObject];
        
        [self.mTableArticles addObjectsFromArray: self.mArticleRequest.articles.allObjects];
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES] autorelease];
        [self.mTableArticles sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        if (![_managedObjectContext save:&error])
        {
            [self alertViewMessage:@"Error" message:@"Database error: Entity Request" goBack:TRUE];
        }
        else
        {
            [_mTableView reloadData];
        }
    }
    else
    {
        self.mArticleRequest             = [NSEntityDescription insertNewObjectForEntityForName:@"ArticleRequest" inManagedObjectContext:_managedObjectContext];
        self.mArticleRequest.user        = self.mUser;
        self.mArticleRequest.startIndex  = [NSNumber numberWithInt:0];
        self.mArticleRequest.value       = self.mSearchRequest;
        self.mArticleRequest.finish      = [NSNumber numberWithBool:FALSE];
        
        if (![_managedObjectContext save:&error])
        {
            [self alertViewMessage:@"Error" message:@"Database error: Entity Request" goBack:TRUE];
        }
        else
        {
            [self getImageViaJSON];
        }
    }
}

- (void)getImageViaJSON
{
    UIAlertView *alertView           = [[[UIAlertView alloc] initWithTitle:@"Loading..." message:@"\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil] autorelease];
    UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
    spinner.center                   = CGPointMake(139.5, 75.5);
    [alertView addSubview:spinner];
    [spinner startAnimating];
    [alertView show];
    
    if (![self.mArticleRequest.finish boolValue])
    {
        NSString *urlString      = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=%d&start=%@&q=", mResultPerPage, self.mArticleRequest.startIndex];
        NSMutableString *baseUrl = [NSMutableString stringWithString:urlString];
        [baseUrl appendString:self.mArticleRequest.value];
        
        NSURL *url                        = [NSURL URLWithString:baseUrl];
        NSURLRequest *request             = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
        {
            if ([[JSON valueForKey:@"responseStatus"] intValue] == 400)
            {
                self.mArticleRequest.finish = [NSNumber numberWithBool:TRUE];
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                [_mTableView reloadData];
            }
            else
            {
                NSArray *results = [JSON valueForKeyPath:@"responseData.results"];
                if (!results || !results.count)
                {
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                    [self alertViewMessage:@"Information" message:@"No result found" goBack:TRUE];
                }
                else
                {
                    int i = 0;
                    for (NSDictionary *lArticleDic in results)
                    {
                        NSError *error     = nil;
                        Articles *lArticle = [NSEntityDescription insertNewObjectForEntityForName:@"Articles" inManagedObjectContext:_managedObjectContext];
                        lArticle.title     = [[lArticleDic objectForKey:JSON_TITLE] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        lArticle.urlImage  = [[lArticleDic objectForKey:JSON_URL] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        lArticle.index     = [NSNumber numberWithInt:[self.mArticleRequest.startIndex intValue] + i];
                        [self.mArticleRequest addArticlesObject:lArticle];
                        if (![_managedObjectContext save:&error])
                        {
                            [alertView dismissWithClickedButtonIndex:0 animated:YES];
                            [self alertViewMessage:@"Error" message:@"Database error: Entity Articles" goBack:TRUE];
                        }
                        else
                        {
                            i++;
                            [self.mTableArticles addObject:lArticle];
                        }
                    }
                    
                    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES] autorelease];
                    [self.mTableArticles sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
                    
                    [self.mTableView reloadData];
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                }
            }
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
        {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            if ([self.mArticleRequest.startIndex intValue] != 0)
            {
                [self alertViewMessage:@"Error" message:@"JSON Request failed" goBack:FALSE];
            }
            else
            {
                [self alertViewMessage:@"Error" message:@"JSON Request failed" goBack:TRUE];
            }
        }];
        [operation start];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (![self.mArticleRequest.finish boolValue])
    {
        if (indexPath.row < self.mTableArticles.count)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Article"] autorelease];
            }
            
            cell.textLabel.text = [[self.mTableArticles objectAtIndex:indexPath.row] title];
            cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
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
    if (self.mTableArticles.count)
    {
        return [self.mArticleRequest.finish boolValue] ? self.mTableArticles.count : self.mTableArticles.count + 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.mTableArticles.count)
    {
        self.mArticleRequest.startIndex = [NSNumber numberWithInt:[self.mArticleRequest.startIndex intValue] + mResultPerPage];
        [self getImageViaJSON];
    }
    else
    {
        DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil articles:self.mTableArticles index:indexPath.row];
        [self.navigationController pushViewController:detailsViewController animated:true];
        [detailsViewController release];
    }
}

@end
