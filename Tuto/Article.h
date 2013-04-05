//
//  Article.h
//  Tuto
//
//  Created by Intern on 03/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article:NSObject
{
    NSString *mTitle;
    NSString *mUrlImage;
}

@property (retain, nonatomic) NSString *mTitle;
@property (retain, nonatomic) NSString *mUrlImage;

- (id)initWithDictionary:(NSDictionary*)_ArticleDictionary;

@end
