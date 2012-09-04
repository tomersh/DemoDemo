//
//  ContentFetchingService.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "ContentFetchingService.h"
#import "ASIHTTPRequest.h"

@interface ContentFetchingService ()

+(BOOL) isAlreadyExecuting:(NSURL*) url;
+(id) getRequestDelegate:(NSURL*) url;
+(void) setRequestDelegate:(id) delegate forRequest:(NSURL*) url;
+(void) removeRequestDelegateForRequest:(NSURL*) url;

@end

@implementation ContentFetchingService

static NSMutableDictionary* requests;

-(id) init {
    return nil; //fuck you
}

+(void) initialize {
    requests = [[NSMutableDictionary alloc] init];
}


+(BOOL) isAlreadyExecuting:(NSURL*) url {
    return [ContentFetchingService getRequestDelegate:url] != nil;
}

+(id) getRequestDelegate:(NSURL*) url {
    @synchronized(requests) {
        return [requests objectForKey:url];
    }
}

+(void) setRequestDelegate:(id) delegate forRequest:(NSURL*) url {
    @synchronized(requests) {
        [requests setObject:delegate forKey:url];
    }
}

+(void) removeRequestDelegateForRequest:(NSURL*) url {
    @synchronized(requests) {
        [requests removeObjectForKey:url];
    }
}


+(void) FetchUrl:(NSURL*) url withStateDelegate:(id) delegate {
    if ([ContentFetchingService isAlreadyExecuting:url]) return;
    [ContentFetchingService setRequestDelegate:delegate forRequest:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:[ContentFetchingService class]];
    [request startAsynchronous];
    NSLog(@"requesting %@",[url absoluteString]);
}


+ (void)requestFinished:(ASIHTTPRequest *)request {
    NSURL* url = request.originalURL;
    NSString* content =  [[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding];
    if (!content) {
        content = [[request responseString] retain];
    }
    id<ContentFetchingServiceStateProtocol> delegate = [ContentFetchingService getRequestDelegate:url];

    if (delegate != nil && [delegate conformsToProtocol:@protocol(ContentFetchingServiceStateProtocol)]) {
        [delegate url:url didFetchSuccessfulyWithData:content andRedirecteUrl:request.url];
    }
    safeRelease(content);
    [ContentFetchingService removeRequestDelegateForRequest:url];
    NSLog(@"sucess, fetched %@",url);
}

+ (void)requestFailed:(ASIHTTPRequest *)request {
    NSURL* url = request.originalURL;
    id<ContentFetchingServiceStateProtocol> delegate = [ContentFetchingService getRequestDelegate:url];
    if (delegate != nil && [delegate conformsToProtocol:@protocol(ContentFetchingServiceStateProtocol)]) {
        [delegate url:url didFetchFailWithError:[NSString stringWithFormat:@"%d",request.responseStatusCode]];
    }
    [ContentFetchingService removeRequestDelegateForRequest:url];
    NSLog(@"failed to fetch %@: errorcode: %d", url, request.responseStatusCode);
}


@end
