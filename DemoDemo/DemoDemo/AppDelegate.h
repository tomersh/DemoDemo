//
//  AppDelegate.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "WebsiteContentFetcher.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WebsiteFetcherDelegateProtocol>

@property (strong, nonatomic) UIWindow *window;

@end
