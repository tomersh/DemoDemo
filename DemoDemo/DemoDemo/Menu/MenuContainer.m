//
//  ViewController.m
//  JTRevealSidebarDemo
//
//  Created by James Apple Tang on 7/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import "MenuContainer.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "SidebarViewController.h"
#import "JTRevealSidebarV2Delegate.h"
#import "CacheableWebsiteViewController.h"
@interface MenuContainer ()
@end

@implementation MenuContainer

@synthesize rightSidebarView, innerView, selectedIndexPath;

-(id)init {
    self = [super init];
    if (!self) return self;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(revealRightSidebar:)];
    
    self.title = @"Bookmarks";
    
    self.navigationItem.revealSidebarDelegate = self;
}

- (void)revealRightSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateRight];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.innerView = nil;
    self.rightSidebarView = nil;
}

-(void)setInnerView:(UIView*)theInnerView {
    [self.innerView removeFromSuperview];
    safeRelease(innerView);
    innerView = [theInnerView retain];
    [self.view addSubview:self.innerView];
    [self.view bringSubviewToFront:self.innerView];
}

#pragma mark JTRevealSidebarDelegate

- (UIView*)viewForRightSidebar {
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableViewController* controller = self.rightSidebarView;
    if (!controller) {
        self.rightSidebarView = [[SidebarViewController alloc] init];
        self.rightSidebarView.sidebarDelegate = self;
        controller = self.rightSidebarView;
    }
    controller.view.frame = CGRectMake(0, viewFrame.origin.y, 270, viewFrame.size.height);
    controller.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    return controller.view;
}

- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}


#pragma mark SidebarViewControllerDelegate

- (void)sidebarViewController:(SidebarViewController *)sidebarViewController didSelectObject:(NSObject *)object atIndexPath:(NSIndexPath *)indexPath {

    [self.navigationController setRevealedState:JTRevealedStateNo];
    if (object) {
        CacheableWebsiteViewController* newInnerViewController = [[CacheableWebsiteViewController alloc] init];
        [newInnerViewController setWebSite:(Website*)object];
        self.innerView = newInnerViewController.view;
    }
}

- (NSIndexPath *)lastSelectedIndexPathForSidebarViewController:(SidebarViewController *)sidebarViewController {
    return self.selectedIndexPath;
}

@end