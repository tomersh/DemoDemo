//
//  Websites.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/4/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "Website.h"
#import "WebsiteContentFetcher.h"

#define WEBSITES_STORAGE_KEY @"WEBSITES_STORAGE_KEY_asfkjllk3j2lk5jlwkfkjh3to2iu6to32qtfgkjhwet6kju"

@interface Websites : NSObject<NSCoding>
{
    NSMutableArray*  websites;
}

@property (nonatomic,retain) NSMutableArray*  websites;


-(void) addWebsite:(Website*)site;
-(void) removeWebsiteAtIndex:(NSUInteger) index;

-(void) prefetchAllWithDelegate:(NSObject<WebsiteFetcherDelegateProtocol>*) delegate;
@end
