//
//  C4MAFHTTPClient.m
//  Bhost
//
//  Created by Emeric Janowski on 10/04/13.
//
//

#import "C4MAFHTTPClient.h"


@implementation C4MAFHTTPClient

@synthesize timeoutInterval;


- (void)setRequestTimeoutInterval:(float)_TimeOut
{
	timeoutInterval = _TimeOut;
}


- (float)getRequestTimeOutInterval
{
	return timeoutInterval;
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest* request = [super requestWithMethod:method path:path parameters:parameters];
    [request setTimeoutInterval:timeoutInterval];
    return request;
}

@end
