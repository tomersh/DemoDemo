//
//  Websites.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "Websites.h"

@implementation Websites

@synthesize websites;

SERIALIZEABLE(Websites)

-(id)init {
    self = [super init];
    if (!self) return self;
    self.websites = [[NSMutableArray alloc] init];
    Website* s1 =[[Website alloc] init];
    s1.url = @"http://www.google.co.il";
    Website* s2 =[[Website alloc] init];
    s2.url = @"http://www.yahoo.com";
    Website* s3 =[[Website alloc] init];
    s3.url = @"http://www.walla.co.il";
    [self addWebsite:s1];
    [self addWebsite:s2];
    [self addWebsite:s3];
    return self;
}

-(void) addWebsite:(Website *)site {
    [self.websites addObject:site];
}

-(void) removeWebsiteAtIndex:(NSUInteger) index {
    [self.websites removeObjectAtIndex:index];
}

-(void) prefetchAllWithDelegate:(NSObject<WebsiteFetcherDelegateProtocol>*) delegate {
    [self.websites each:^(Website* website) {
        [website prefetchWithDelegate:delegate];
    }];
}


-(void)dealloc {
    self.websites = nil;
    [super dealloc];
}

@end
