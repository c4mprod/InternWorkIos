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
        self.mTableArticles       = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self dataCoreArticleRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_mTableView release];
    [mUser release];
    [mSearchRequest release];
    [mTableArticles release];
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
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"user = %@ AND value = %@", mUser, mSearchRequest];
    [query setEntity:entity];
    [query setPredicate:predicate];
    [query setFetchLimit:1];
    
    NSError *error = nil;
    if ([_managedObjectContext countForFetchRequest:query error:&error])
    {
        self.mArticleRequest = [[_managedObjectContext executeFetchRequest:query error:&error] lastObject];
        
        [mTableArticles addObjectsFromArray: mArticleRequest.articles.allObjects];
        NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES] autorelease];
        [mTableArticles sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
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
        self.mArticleRequest        = [NSEntityDescription insertNewObjectForEntityForName:@"ArticleRequest" inManagedObjectContext:_managedObjectContext];
        mArticleRequest.user        = mUser;
        mArticleRequest.startIndex  = [NSNumber numberWithInt:0];
        mArticleRequest.value       = mSearchRequest;
        mArticleRequest.finish      = [NSNumber numberWithBool:FALSE];
        
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
    
    if (![mArticleRequest.finish boolValue])
    {
        NSString *urlString      = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=%d&start=%@&q=", mResultPerPage, mArticleRequest.startIndex];
        NSMutableString *baseUrl = [NSMutableString stringWithString:urlString];
        [baseUrl appendString:mArticleRequest.value];
        
        NSURL *url                        = [NSURL URLWithString:baseUrl];
        NSURLRequest *request             = [NSURLRequest requestWithURL:url];
#if TARGET_NAME == ApplicationTest
        // Nécessaire uniquement lors du test de l'application, pour attendre que la requête JSON soit terminée
        __block int testStatus = 0;
#endif
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
        {
            if ([[JSON valueForKey:@"responseStatus"] intValue] == 400)
            {
                mArticleRequest.finish = [NSNumber numberWithBool:TRUE];
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                [_mTableView reloadData];
            }
            else
            {
                NSArray *results = [JSON valueForKeyPath:@"responseData.results"];
                if (!results || results.count == 0)
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
                        lArticle.index     = [NSNumber numberWithInt:[mArticleRequest.startIndex intValue] + i];
                        [mArticleRequest addArticlesObject:lArticle];
                        if (![_managedObjectContext save:&error])
                        {
                            [alertView dismissWithClickedButtonIndex:0 animated:YES];
                            [self alertViewMessage:@"Error" message:@"Database error: Entity Articles" goBack:TRUE];
                        }
                        else
                        {
                            i++;
                            [mTableArticles addObject:lArticle];
                        }
                    }
                    
                    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES] autorelease];
                    [mTableArticles sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
                    
                    [_mTableView reloadData];
                    [alertView dismissWithClickedButtonIndex:0 animated:YES];
                }
            }
#if TARGET_NAME == ApplicationTest
            testStatus = 1;
#endif
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
        {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            if ([mArticleRequest.startIndex intValue] != 0)
            {
                [self alertViewMessage:@"Error" message:@"JSON Request failed" goBack:FALSE];
            }
            else
            {
                [self alertViewMessage:@"Error" message:@"JSON Request failed" goBack:TRUE];
            }
#if TARGET_NAME == ApplicationTest
            testStatus = 2;
#endif
        }];
        [operation start];
#if TARGET_NAME == ApplicationTest
        while (testStatus == 0)
        {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
        }
#endif
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (![mArticleRequest.finish boolValue])
    {
        if (indexPath.row < mTableArticles.count)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
            if (!cell)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Article"] autorelease];
            }
            
            cell.textLabel.text = [[mTableArticles objectAtIndex:indexPath.row] title];
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
    if (mTableArticles.count != 0)
    {
        return [mArticleRequest.finish boolValue] ? mTableArticles.count : mTableArticles.count + 1;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == mTableArticles.count)
    {
        mArticleRequest.startIndex = [NSNumber numberWithInt:[mArticleRequest.startIndex intValue] + mResultPerPage];
        [self getImageViaJSON];
    }
    else
    {
        DetailsViewController *detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil articles:mTableArticles index:indexPath.row];
        [self.navigationController pushViewController:detailsViewController animated:true];
        [detailsViewController release];
    }
}

@end
