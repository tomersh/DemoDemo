//
//  WebsiteContentFetcher.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "ContentFetchingService.h"
#import "WebsiteContent.h"
#import "Website.h"

@protocol WebsiteFetcherDelegateProtocol <NSObject>

@optional
-(void) didStartsContentDownload:(NSString*) url;
-(void) didFinishContentDownlaod:(WebsiteContent*) content;
-(void) didFailRetrievingContent:(NSString*) url;
@end

@interface WebsiteContentFetcher : NSObject<ContentFetchingServiceStateProtocol>

+(WebsiteContent*) fetchWebsiteContent:(Website*) website WithDelegate:(NSObject<WebsiteFetcherDelegateProtocol>*) delegate;
+(void) url:(NSURL*) url didFetchSuccessfulyWithData:(NSString*) data andRedirecteUrl:(NSURL*)redirectedUrl;
+(void) url:(NSURL*) url didFetchFailWithError:(NSString*) error;
@end
