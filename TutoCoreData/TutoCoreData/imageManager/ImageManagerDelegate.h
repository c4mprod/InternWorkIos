/*
 *  ImageManagerDelegate.h
 *  ImageManagerDelegate
 *
 *  Created by PrigentRoudaut on 13/11/09.
 *  Copyright 2009 C4M Prod. All rights reserved.
 *
 */

@protocol ImageManagerDelegate

- (void) didFailDownloadImage:(NSString*)_URLImage;
- (void) didUpdateImage:(NSArray*)_array;
- (void) willUpdateImage;
- (NSString*) getCurrentURLImage;
- (void) setCurrentURLImage:(NSString*)_URLImage;
@end