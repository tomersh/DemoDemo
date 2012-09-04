//
//  Website.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/3/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

@protocol WebsiteFetcherDelegateProtocol;

@interface Website : NSObject<NSCoding> {
    NSString* url;
}

@property (nonatomic,retain) NSString* url;

-(id) initWithUrl:(NSString*) _url ;

-(void) prefetchWithDelegate:(NSObject<WebsiteFetcherDelegateProtocol>*) delegate;

@end
