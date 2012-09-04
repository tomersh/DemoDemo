//
//  ViewController.h
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTRevealSidebarV2Delegate.h"
#import "SidebarViewController.h"


@interface MenuContainer : UIViewController <JTRevealSidebarV2Delegate, SidebarViewControllerDelegate> {
    SidebarViewController* rightSidebarView;
    UIView* innerView;
    NSIndexPath* selectedIndexPath;
}

@property (nonatomic, retain) SidebarViewController* rightSidebarView;
@property (nonatomic, retain) UIView* innerView;
@property (nonatomic, retain) NSIndexPath* selectedIndexPath;


@end
