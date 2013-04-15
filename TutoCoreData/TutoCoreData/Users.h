//
//  Users.h
//  TutoCoreData
//
//  Created by Intern on 10/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ArticleRequest;

@interface Users : NSManagedObject

@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSSet *articleRequests;
@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addArticleRequestsObject:(ArticleRequest *)value;
- (void)removeArticleRequestsObject:(ArticleRequest *)value;
- (void)addArticleRequests:(NSSet *)values;
- (void)removeArticleRequests:(NSSet *)values;

@end
