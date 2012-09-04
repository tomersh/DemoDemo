//
//  WebsiteContentFetcher.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "WebsiteContentFetcher.h"
#import "PersistentStorageProvider.h"

@interface WebsiteContentFetcher ()

+(id) getRequestDelegate:(NSString*) request;
+(void) setRequestDelegate:(id) delegate forRequest:(NSString*) request;
+(void) removeRequestDelegateForRequest:(NSString*) request;
+(BOOL) isAlreadyExecuting:(NSString*) request;

+(NSString*) generateKeyForWebsite:(NSString*) url;
+(BOOL) shouldFetchFromWeb:(WebsiteContent*) website;

@end

@implementation WebsiteContentFetcher

static NSMutableDictionary* requests;

-(id) init {
    return nil; //fuck you
}

+(void) initialize {
    requests = [[NSMutableDictionary alloc] init];
}

+(BOOL) isAlreadyExecuting:(NSString*) request {
    return [WebsiteContentFetcher getRequestDelegate:request] != nil;
}

+(id) getRequestDelegate:(NSString*) request {
    @synchronized(requests) {
        return [requests objectForKey:request];
    }
}

+(void) setRequestDelegate:(id) delegate forRequest:(NSString*) request {
    @synchronized(requests) {
        [requests setObject:delegate forKey:request];
    }
}

+(void) removeRequestDelegateForRequest:(NSString*) request {
    @synchronized(requests) {
        [requests removeObjectForKey:request];
    }
}

+(WebsiteContent*) fetchWebsiteContent:(Website*) website WithDelegate:(NSObject<WebsiteFetcherDelegateProtocol>*) delegate {
    NSLog(@"fetching: %@",website);
    NSString* key = [WebsiteContentFetcher generateKeyForWebsite:website.url];
    
    WebsiteContent* content = [PersistentStorageProvider fetchObjectByKey:key];
    
    [WebsiteContentFetcher setRequestDelegate:delegate forRequest:key];
    
    if (!content || [WebsiteContentFetcher shouldFetchFromWeb:content]) {
        if ([WebsiteContentFetcher isAlreadyExecuting:key])
            [WebsiteContentFetcher setRequestDelegate:delegate forRequest:key]; //<- change ownership
        if ([delegate respondsToSelector:@selector(didStartsContentDownload:)])
            [delegate performSelector:@selector(didStartsContentDownload:) withObject:website.url];
        [ContentFetchingService FetchUrl:[NSURL URLWithString:website.url] withStateDelegate:[WebsiteContentFetcher class]];
        NSLog(@"starting fetch from web: %@",website.url);
    }
    return content;
}

+(BOOL) shouldFetchFromWeb:(WebsiteContent*) website {
    return NO;
    //return [website.lastupdated dateByAddingTimeInterval: 60 * 60] < [NSDate date];
}

+(void) url:(NSURL*) url didFetchSuccessfulyWithData:(NSString*) data andRedirecteUrl:(NSURL*)redirectedUrl {
    NSString* key = [WebsiteContentFetcher generateKeyForWebsite:[url absoluteString]];
    NSObject<WebsiteFetcherDelegateProtocol>* delegate = [WebsiteContentFetcher getRequestDelegate:key];
    WebsiteContent* content = [[WebsiteContent alloc] initWithWebsite:[redirectedUrl absoluteString] andContent:data andUpdateDate:[NSDate date]];
    [PersistentStorageProvider storeObject:content withKey:key];
    if ([delegate respondsToSelector:@selector(didFinishContentDownlaod:)]) {
        [delegate performSelector:@selector(didFinishContentDownlaod:) withObject:content];
    }
    [WebsiteContentFetcher removeRequestDelegateForRequest:key];
    NSLog(@"done fetching from: %@",url);
    safeRelease(content);
    
}

+(void) url:(NSURL*) url didFetchFailWithError:(NSString*) error {
    NSString* key = [WebsiteContentFetcher generateKeyForWebsite:[url absoluteString]];
    NSObject<WebsiteFetcherDelegateProtocol>* delegate = [WebsiteContentFetcher getRequestDelegate:key];
    if ([delegate respondsToSelector:@selector(didFailRetrievingContent:)])
        [delegate performSelector:@selector(didFailRetrievingContent:) withObject:[url absoluteString]];
    NSLog(@"error while fetching from: %@",url);
    [WebsiteContentFetcher removeRequestDelegateForRequest:key];
    
}

+(NSString*) generateKeyForWebsite:(NSString*) url {
    return [@"WebsiteStorage:" stringByAppendingString:url];
}

@end
