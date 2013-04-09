//
//  Articles.h
//  Tuto
//
//  Created by Intern on 08/04/13.
//  Copyright (c) 2013 Intern. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Articles : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * urlImage;

@end
