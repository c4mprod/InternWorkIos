//
//  ImageViewManager.h
//  PlayGround
//
//  Created by Prigent roudaut on 15/09/10.
//  Copyright 2010 c4mprod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageManagerDelegate.h"
#import "ImageViewManagerDelegate.h"


//"imageInstance"///.image = [[ImageManager sharedImageManager] getImageNamed:///@"URLNAME"// withDelegate://"imageInstance"//];
@class ImageClass;
@interface ImageViewManager : UIImageView<ImageManagerDelegate>
{
	NSObject<ImageViewManagerDelegate>*         mImageViewManagerDelegate;
    UIActivityIndicatorView *                   mActivity;
}
@property (nonatomic, retain) NSObject<ImageViewManagerDelegate>*   mImageViewManagerDelegate;
@property (nonatomic, retain) UIImage*								mDefaultImage;
@property (nonatomic, retain) NSString*                             mCurrentURLImage;

@end
