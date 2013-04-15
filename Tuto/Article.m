//
//  Article.m
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "Article.h"

@implementation Article

@synthesize mTitle;
@synthesize mUrlImage;

- (id)initWithDictionary:(NSDictionary*)_ArticleDictionary
{
    self = [super init];
    if (self)
    {
        NSString *jsonTitle = [_ArticleDictionary objectForKey:JSON_TITLE];
        NSString *jsonUrl   = [_ArticleDictionary objectForKey:JSON_URL];
        self.mTitle         = [jsonTitle stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.mUrlImage      = [jsonUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}

@end
