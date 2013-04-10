//
//  AFHTTPImageManagerClient.m
//  Bhost
//
//  Created by Emeric Janowski on 3/25/13.
//
//

#import "AFHTTPImageManagerClient.h"

@implementation AFHTTPImageManagerClient

static AFHTTPImageManagerClient *	sharedBoastImageManagerInstance = nil;

+ (AFHTTPImageManagerClient*)sharedAFHTTPImageManagerClient
{
	if (sharedBoastImageManagerInstance == nil)
	{
		sharedBoastImageManagerInstance = [[AFHTTPImageManagerClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://c4mprod.com"]];
	}
	
	return sharedBoastImageManagerInstance;
}


@end
