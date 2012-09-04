//
//  Website.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/3/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "Website.h"
#import "WebsitecontentFetcher.h"

@implementation Website

@synthesize url;

SERIALIZEABLE(Website);

-(id) initWithUrl:(NSString*) _url {
    self = [self init];
    if (!self) return self;
    if (![_url hasPrefix:@"http://"]) {
        _url = [@"http://" stringByAppendingString:_url];
    }
    self.url = _url;
    return self;
}

-(void) prefetchWithDelegate:(NSObject<WebsiteFetcherDelegateProtocol>*) delegate {
    [WebsiteContentFetcher fetchWebsiteContent:self WithDelegate:delegate];
}

-(NSString *)description {
    return self.url;
}

-(void)dealloc {
    self.url = nil;
    [super dealloc];
}

@end
