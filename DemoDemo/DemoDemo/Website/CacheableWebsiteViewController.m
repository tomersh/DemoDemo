//
//  CacheableWebsiteViewController.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/3/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "CacheableWebsiteViewController.h"
#import "WebsiteContentFetcher.h"

@interface CacheableWebsiteViewController ()

-(UIView*) generateLoadingView;
-(void) removeLoadingView;

@end

@implementation CacheableWebsiteViewController

-(id)init {
    self = [super init];
    if (!self) return self;
    webView = [[UIWebView alloc] init];
    loadingView = [[self generateLoadingView] retain];
    return self;
}

-(UIView*) generateLoadingView {
    CGRect viewFrame = self.view.frame;
    UIView* container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewFrame.size.width,viewFrame.size.height)];
	container.autoresizingMask = UIViewAutoresizingNone;
	[container setOpaque:NO];
	[container setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.25]];
    UIActivityIndicatorView *activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] autorelease];
	activityIndicator.isAccessibilityElement=YES;
	activityIndicator.accessibilityLabel=@"Loading";
	activityIndicator.center = CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2);
	[activityIndicator startAnimating];
    [container addSubview:activityIndicator];
	return [container autorelease];
}

-(void) removeLoadingView {
    [loadingView removeFromSuperview];
}

-(void) setWebSite:(Website*) website {
    WebsiteContent* content = [WebsiteContentFetcher fetchWebsiteContent:website WithDelegate:self];
    if (content) {
        [self didFinishContentDownlaod:content];
    }
}

-(void) didStartsContentDownload:(NSString*) url {
    [self.view addSubview:loadingView];
}

-(void) didFinishContentDownlaod:(WebsiteContent*) content {
    NSLog(@"%@",content.url);
    [webView loadHTMLString:content.content baseURL:[NSURL URLWithString:content.url]];
    [self removeLoadingView];
}

-(void) didFailRetrievingContent:(NSString*) url {
    [self removeLoadingView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 320, 460);
	webView.frame = self.view.frame;
    [self.view addSubview:webView];
}

- (void)viewDidUnload
{
   // safeRelease(webView);
    //safeRelease(loadingView);
    [super viewDidUnload];
}


@end
