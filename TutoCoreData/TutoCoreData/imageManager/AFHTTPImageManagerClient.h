//
//  AFHTTPImageManagerClient.h
//  Bhost
//
//  Created by Emeric Janowski on 3/25/13.
//
//

#import "C4MAFHTTPClient.h"

@interface AFHTTPImageManagerClient : C4MAFHTTPClient

+ (AFHTTPImageManagerClient*)sharedAFHTTPImageManagerClient;

@end
