//
//  ImageViewPatern.m
//  Bhost
//
//  Created by Prigent Roudaut on 24/05/12.
//  Copyright (c) 2012 C4MProd. All rights reserved.
//

#import "ImageViewPatern.h"

@implementation ImageViewPatern


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self =  [super initWithCoder:aDecoder];
    if (self)
    {
        UIColor* lUIColor = [UIColor colorWithPatternImage:self.image];
        self.image = nil;
        self.backgroundColor = lUIColor;
    }
    return self;
}



@end
