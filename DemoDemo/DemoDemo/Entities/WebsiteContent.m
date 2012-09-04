//
//  WebsiteContent.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "WebsiteContent.h"

@implementation WebsiteContent

@synthesize url, content, lastupdated;

SERIALIZEABLE(WebsiteContent)

-(id)initWithWebsite:(NSString*) theUrl andContent:(NSString*)theContent andUpdateDate:(NSDate*) date {
    self = [self init];
    if (!self) return self;
    self.url = theUrl;
    self.content = theContent;
    self.lastupdated = date;
    return self;
}

-(void)dealloc {
    self.url = nil;
    self.content = nil;
    self.lastupdated = nil;
    [super dealloc];
}

@end
