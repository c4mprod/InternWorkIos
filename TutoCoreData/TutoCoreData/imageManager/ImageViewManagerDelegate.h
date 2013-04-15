//
//  ImageViewManagerDelegate.h
//  YourShape
//
//  Created by Prigent roudaut on 23/11/10.
//  Copyright 2010 c4mprod. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpriteManager;
@class ImageViewManager;
@protocol ImageViewManagerDelegate

@optional

- (void) updateImageViewManager:(ImageViewManager *)_ImageViewManager;
- (void) updateSpriteManager:(SpriteManager *)_SpriteManager;
@end
