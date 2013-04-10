//
//  ImageViewManager.m
//  PlayGround
//
//  Created by Prigent roudaut on 15/09/10.
//  Copyright 2010 c4mprod. All rights reserved.
//

#import "ImageViewManager.h"
#import "ImageManager.h"


#import <QuartzCore/QuartzCore.h>

@implementation ImageViewManager


@synthesize mImageViewManagerDelegate;
@synthesize mDefaultImage;



- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
        mActivity		= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        mActivity.frame = CGRectMake(self.frame.size.width/2 - mActivity.frame.size.width/2,  self.frame.size.height/2 - mActivity.frame.size.height/2,mActivity.frame.size.width, mActivity.frame.size.height );
        [self addSubview:mActivity];
		mDefaultImage	= nil;
		
	}
	return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
        mActivity		= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        mActivity.frame = CGRectMake(self.frame.size.width/2 - mActivity.frame.size.width/2,  self.frame.size.height/2 - mActivity.frame.size.height/2,mActivity.frame.size.width, mActivity.frame.size.height );
		
        [self addSubview:mActivity];
	}
	return self;
}

-(void)willUpdateImage
{
    [mActivity startAnimating];
    [self addSubview:mActivity];
}

- (void) didFailDownloadImage:(NSNotification*)_notification
{
    [mActivity removeFromSuperview];
	
    NSString* urlImage = [_notification object];
    
	if ([urlImage length] > 0)
	{
		[[NSNotificationCenter defaultCenter] removeObserver:self name:urlImage object:nil];
    }
	self.image = mDefaultImage;
}

- (void) didUpdateImage:(NSNotification*)_notification
{
    [mActivity removeFromSuperview];
    NSArray* array = [_notification object];
	if ([array count] > 1 && [array objectAtIndex:1] != nil)
	{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:[array objectAtIndex:0] object:nil];
		self.image = [array objectAtIndex:1];
	}
	else
	{
		self.image = mDefaultImage;
	}
	if (mImageViewManagerDelegate != nil && [mImageViewManagerDelegate respondsToSelector:@selector(updateImageViewManager:)])
	{
		[mImageViewManagerDelegate updateImageViewManager:self];
	}
}


- (NSString*) getCurrentURLImage
{
    return self.mCurrentURLImage;
}


- (void) setCurrentURLImage:(NSString*)_URLImage
{
    self.mCurrentURLImage = _URLImage;
}


- (void) dealloc
{
	//   [[ImageManager sharedImageManager] performSelectorOnMainThread:@selector(removeDelegate:) withObject:self waitUntilDone:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [mActivity release];
	[mDefaultImage release];
	[super dealloc];
}

/*
 +(UIImage *)makeRoundedImage:(UIImageView *) imageView
 radius: (float) radius
 {
 //imageView.layer.masksToBounds = YES;
 //imageView.layer.cornerRadius = radius;
 
 UIGraphicsBeginImageContextWithOptions(imageView.image.size, NO, [UIScreen mainScreen].scale);
 
 CGPoint point = CGPointMake(imageView.frame.size.width/2.0, imageView.frame.size.height/2.0);
 [[UIBezierPath bezierPathWithRoundedRect:(CGRect){point, imageView.frame.size} cornerRadius:radius] addClip];
 [imageView.image drawInRect:CGRectMake(0,0, imageView.image.size.width, imageView.image.size.height)];
 
 UIImage* new = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 return new;
 
 }*/

@end
