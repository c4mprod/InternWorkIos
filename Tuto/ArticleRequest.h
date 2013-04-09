//
//  ArticleRequest.h
//  Tuto
//
//  Created by Intern on 08/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Articles;

@interface ArticleRequest : NSManagedObject

@property (nonatomic, retain) NSNumber * finish;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSSet *article;

@end

@interface ArticleRequest (CoreDataGeneratedAccessors)

- (id)initWithIndex:(int64_t*)_index value:(NSString *)_value finish:(BOOL)_finish;

- (void)addArticleObject:(Articles *)value;
- (void)removeArticleObject:(Articles *)value;
- (void)addArticle:(NSSet *)values;
- (void)removeArticle:(NSSet *)values;

@end
