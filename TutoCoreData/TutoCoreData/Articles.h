//
//  Articles.h
//  TutoCoreData
//
//  Created by Intern on 10/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ArticleRequest;

@interface Articles : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * urlImage;
@property (nonatomic, retain) ArticleRequest *articleRequest;

@end
