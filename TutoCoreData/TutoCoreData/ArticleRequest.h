//
//  ArticleRequest.h
//  TutoCoreData
//
//  Created by Intern on 09/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Articles;

@interface ArticleRequest : NSManagedObject

@property (nonatomic, retain) NSNumber * finish;
@property (nonatomic, retain) NSNumber * startIndex;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSSet *articles;
@end

@interface ArticleRequest (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(Articles *)value;
- (void)removeArticlesObject:(Articles *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

@end
