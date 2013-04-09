//
//  ArticleRequest.m
//  Tuto
//
//  Created by Intern on 08/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import "ArticleRequest.h"
#import "Articles.h"


@implementation ArticleRequest

@dynamic finish;
@dynamic index;
@dynamic value;
@dynamic article;

- (id)initWithIndex:(NSNumber *)_index value:(NSString *)_value finish:(NSNumber *)_finish
{
    self = [super init];
    if (self)
    {
        self.index  = _index;
        self.value  = _value;
        self.finish = _finish;
    }
    return self;
}

@end
