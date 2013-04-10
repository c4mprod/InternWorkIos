//
//  ImageManager.h
//  Universal
//
//  Created by Jean-Denis Pauleau on 14/04/10.
//  Copyright 2010 C4MProd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import "ImageManagerDelegate.h"

@interface ImageManager : NSObject

@property (nonatomic, retain) NSMutableDictionary*  mDicoImage;
@property (nonatomic, retain) NSMutableArray*       mArrayKey;

@property (nonatomic, retain) NSMutableArray*               mImageAlreadyDownload;

- (UIImage *)	   getImageNamed:(NSString *)urlImage withDelegate:(NSObject<ImageManagerDelegate> *)delegate;
- (void)		   fifoStack;
+ (ImageManager *) sharedImageManager;

@end