//
//  ImageViewManagerRounded.m
//  Bhost
//
//  Created by Raphaël Pinto on 11/12/12.
//
//

#import "ImageViewManagerRounded.h"


@implementation ImageViewManagerRounded


@synthesize mImageRoundRadius;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



#pragma mark -
#pragma mark Data Management



- (void)setImage:(UIImage *)image
{
	[super setImage:[ImageViewManagerRounded makeRoundedUIImage:image radius:image.size.width / mImageRoundRadius]];
}

+ (UIImage*) makeRoundedUIImage: (UIImage*) orig radius:(CGFloat) r
{
    UIGraphicsBeginImageContextWithOptions(orig.size, NO, 0);
    CGSize taille;
    if(orig.size.width > orig.size.height)
    {
        taille = CGSizeMake(orig.size.height, orig.size.height);
    }
    else
    {
		taille = CGSizeMake(orig.size.width, orig.size.width);
    }
    CGPoint point = CGPointMake((orig.size.width - taille.width)/2.0, (orig.size.height - taille.height)/2.0);
    [[UIBezierPath bezierPathWithRoundedRect:(CGRect){point, taille} cornerRadius:r] addClip];
    [orig drawInRect:(CGRect){CGPointZero, orig.size}];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


+ (UIImage*) makeRoundedImage: (UIImageView*) orig radius:(CGFloat) r
{
    UIGraphicsBeginImageContextWithOptions(orig.image.size, NO, 0);
    CGSize taille;
    if(orig.image.size.width > orig.image.size.height)
    {
        taille = CGSizeMake(orig.image.size.height, orig.image.size.height);
    }
    else
    {
		taille = CGSizeMake(orig.image.size.width, orig.image.size.width);
    }
    CGPoint point = CGPointMake((orig.image.size.width - taille.width)/2.0, (orig.image.size.height - taille.height)/2.0);
    [[UIBezierPath bezierPathWithRoundedRect:(CGRect){point, taille} cornerRadius:r] addClip];
    [orig.image drawInRect:(CGRect){CGPointZero, orig.image.size}];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
