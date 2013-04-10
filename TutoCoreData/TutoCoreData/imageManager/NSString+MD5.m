//
//  NSString+MD5.m
//  Bhost
//
//  Created by Raphaël Pinto on 20/12/12.
//
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (NSString_MD5)


+ (NSString *) md5:(NSString *) input
{
	const char *cStr = [input UTF8String];
	unsigned char digest[16];
	CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
	
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
	
	return  output;
	
}


@end
