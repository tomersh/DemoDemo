//
//  CacheableWebsiteViewController.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/3/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "Website.h"
#import "WebsiteContentFetcher.h"

@interface CacheableWebsiteViewController : UIViewController<WebsiteFetcherDelegateProtocol> {
    UIWebView* webView;
    UIView* loadingView;
}

-(void) setWebSite:(Website*) website;

@end
