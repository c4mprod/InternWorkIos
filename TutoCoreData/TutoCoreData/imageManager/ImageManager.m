//
//  ImageManager.m
//  Universal
//
//  Created by Jean-Denis Pauleau on 14/04/10.
//  Copyright 2010 C4MProd. All rights reserved.
//

#warning Move this in PCH
#define kTimeOutIntervalDefault 10

#import "ImageManager.h"
#import "AFImageRequestOperation.h"
#import "AFHTTPImageManagerClient.h"
#import "NSString+MD5.h"

@implementation ImageManager
@synthesize mDicoImage;
@synthesize mArrayKey;
@synthesize mImageAlreadyDownload;

static ImageManager *	sharedImageManagerInstance = nil;

+ (ImageManager *)sharedImageManager
{
	if (sharedImageManagerInstance == nil)
	{
		sharedImageManagerInstance = [[ImageManager alloc] init];
	}
	return sharedImageManagerInstance;
}

- (id) init
{
	self = [super init];
	
	if (self)
	{
		self.mDicoImage				= [NSMutableDictionary  dictionary];
        self.mArrayKey              = [NSMutableArray       array];
        self.mImageAlreadyDownload  = [NSMutableArray       array];
	}
	return self;
}

- (void) dealloc
{
    //C4MLog(@"");
    NSLog(@"");
	[mDicoImage     release];
    [mArrayKey      release];
    [mImageAlreadyDownload release];
	[super dealloc];
}


- (UIImage *) getImageNamed:(NSString *)urlImage withDelegate:(NSObject <ImageManagerDelegate> *)delegate
{
	if (   (!urlImage || [urlImage isKindOfClass:[NSNull class]])    && (delegate && ![delegate isKindOfClass:[NSNull class]]))
	{
		[delegate didFailDownloadImage:nil];
		return nil;
	}
	
	if (delegate && ![delegate isKindOfClass:[NSNull class]])
	{
		[[NSNotificationCenter defaultCenter] removeObserver:delegate name:[delegate getCurrentURLImage] object:nil];
		[[NSNotificationCenter defaultCenter] removeObserver:delegate name:[NSString stringWithFormat:@"ERROR_%@",[delegate getCurrentURLImage]] object:nil];
		[delegate setCurrentURLImage:urlImage];
		[[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(didUpdateImage:) name:urlImage object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:delegate selector:@selector(didFailDownloadImage:) name:[NSString stringWithFormat:@"ERROR_%@",urlImage] object:nil];
		[delegate willUpdateImage];
	}
	
    
	if(urlImage != nil && ![urlImage isKindOfClass:[NSNull class]])
	{
        NSURLRequest * request= [NSURLRequest requestWithURL:[NSURL URLWithString:urlImage]];
        // Image in memory
        if ([mDicoImage valueForKey:urlImage] != nil && ![self.mImageAlreadyDownload containsObject:urlImage])
		{
            [[NSNotificationCenter defaultCenter] postNotificationName:urlImage object:[NSArray arrayWithObjects:urlImage,[mDicoImage valueForKey:urlImage],nil]];
			return [mDicoImage valueForKey:urlImage];
		}
        //URL Request
        NSCachedURLResponse* cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        // cached response
        if(cachedResponse != nil && ![self.mImageAlreadyDownload containsObject:urlImage])
        {
            UIImage* tmpImage = [UIImage imageWithData:cachedResponse.data];
            if(tmpImage)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:urlImage object:[NSArray arrayWithObjects:urlImage,tmpImage,nil]];
                [self performSelectorOnMainThread: @selector(addImageViewInArray:) withObject:[NSMutableArray arrayWithObjects:tmpImage,urlImage, nil] waitUntilDone:YES];
                return tmpImage;
            }
        }
		// Image write in NSTemporaryDirectory.
        NSString* path= [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString md5:urlImage]];
		if ([[NSFileManager defaultManager] fileExistsAtPath:path] && ![self.mImageAlreadyDownload containsObject:urlImage])
		{
            UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
            if(image)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:urlImage object:[NSArray arrayWithObjects:urlImage,image,nil]];
                [self performSelectorOnMainThread: @selector(addImageViewInArray:) withObject:[NSMutableArray arrayWithObjects:image,urlImage, nil] waitUntilDone:YES];
                return image;
            }
		}
        // Download image
        else
        {
            if([self.mImageAlreadyDownload containsObject:urlImage])
            {
            }
            else
            {
                [mImageAlreadyDownload addObject:urlImage];
                AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
                operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     NSError* loadImageError = nil;
                     UIImage* tmpImage = [UIImage imageWithData:[NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:&loadImageError]];
                     if(tmpImage && loadImageError == nil)
                     {
						 [[NSNotificationCenter defaultCenter] postNotificationName:urlImage object:[NSArray arrayWithObjects:urlImage,tmpImage,nil]];
						 [self performSelectorOnMainThread: @selector(addImageViewInArray:) withObject:[NSMutableArray arrayWithObjects:tmpImage,urlImage, nil] waitUntilDone:YES];
                     }
                     else
                     {
                         if(loadImageError)
                         {
                             //C4MLog(@"ERROR WHEN LOAD IMAGE : %@",loadImageError);
                             NSLog(@"ERROR WHEN LOAD IMAGE : %@",loadImageError);
                         }
                         [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                         [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"ERROR_%@",urlImage] object:urlImage];
                     }
					 [mImageAlreadyDownload removeObject:urlImage];
                 }
                                                 failure:^(AFHTTPRequestOperation *operation, NSError *error)
                 {
                     [mImageAlreadyDownload removeObject:urlImage];
                     [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                     [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"ERROR_%@",urlImage] object:urlImage];
                 }];
                [AFHTTPImageManagerClient sharedAFHTTPImageManagerClient].timeoutInterval = kTimeOutIntervalDefault;
                [[AFHTTPImageManagerClient sharedAFHTTPImageManagerClient] enqueueHTTPRequestOperation:operation];
                
                return nil;
            }
        }
        return nil;
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"ERROR_%@",urlImage] object:urlImage];
	return nil;
}



- (void) fifoStack
{
    if ([[mDicoImage allKeys] count] > 40)
    {
        [mDicoImage removeObjectForKey:[mArrayKey objectAtIndex:0]];
        [mArrayKey removeObjectAtIndex:0];
    }
}


- (void) addImageViewInArray:(NSMutableArray*)urlImageArray
{
    [mDicoImage setValue:[urlImageArray objectAtIndex:0] forKey:[urlImageArray objectAtIndex:1]];
    [mArrayKey addObject:[urlImageArray objectAtIndex:1]];
    
    [self fifoStack];
}




@end