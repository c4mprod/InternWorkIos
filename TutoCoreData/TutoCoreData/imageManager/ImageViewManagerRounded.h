//
//  ImageViewManagerRounded.h
//  Bhost
//
//  Created by Raphaël Pinto on 11/12/12.
//
//

#import "ImageViewManager.h"

@interface ImageViewManagerRounded : ImageViewManager


@property (nonatomic) int		mImageRoundRadius;


+(UIImage *)makeRoundedImage:(UIImageView *) imageView
					  radius:(float) radius;
+ (UIImage*) makeRoundedUIImage:(UIImage*)orig radius:(CGFloat)r;


@end
