//
//  ContentFetchingService.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol ContentFetchingServiceStateProtocol <NSObject>

+(void) url:(NSURL*) url didFetchSuccessfulyWithData:(NSString*) data andRedirecteUrl:(NSURL*) redirectedUrl;
+(void) url:(NSURL*) url didFetchFailWithError:(NSString*) error;

@end


@interface ContentFetchingService : NSObject<ASIHTTPRequestDelegate>

+(void) FetchUrl:(NSURL*) url withStateDelegate:(id) delegate;

@end
