//
//  SidebarViewController.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "Websites.h"

@protocol SidebarViewControllerDelegate;
@protocol WebsiteFetcherDelegateProtocol;

@interface SidebarViewController : UITableViewController<WebsiteFetcherDelegateProtocol>
{
    Websites* sites;
}

@property (nonatomic, assign) NSObject<SidebarViewControllerDelegate>* sidebarDelegate;

@end

@protocol SidebarViewControllerDelegate <NSObject>

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController;

@end
