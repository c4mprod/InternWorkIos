//
//  ArticleRequest.h
//  TutoCoreData
//
//  Created by Intern on 10/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Articles, Users;

@interface ArticleRequest : NSManagedObject

@property (nonatomic, retain) NSNumber * finish;
@property (nonatomic, retain) NSNumber * startIndex;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSSet *articles;
@property (nonatomic, retain) Users *user;
@end

@interface ArticleRequest (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(Articles *)value;
- (void)removeArticlesObject:(Articles *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

@end
