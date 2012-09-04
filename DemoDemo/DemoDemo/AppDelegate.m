//
//  AppDelegate.m
//  DemoDemo
//
//  Created by Tomer shiri on 9/2/12.
//  Copyright (c) 2012 Tomer shiri. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuContainer.h"
#import "Websites.h"
#import "PersistentStorageProvider.h"

@interface AppDelegate ()

-(void) prefetchSites;

@end

@implementation AppDelegate

- (void)dealloc
{
    safeRelease(_window);
    [super dealloc];
}

-(void) prefetchSites {
    Websites* sites = [[PersistentStorageProvider fetchObjectByKey:WEBSITES_STORAGE_KEY] retain];
    if (!sites) {
        sites = [[Websites alloc] init];
    }
    if (sites) {
        [sites prefetchAllWithDelegate:self];
    }
    safeRelease(sites);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window makeKeyAndVisible];
    MenuContainer* mainViewController = [[MenuContainer alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:self.window.rootViewController];
    self.window.rootViewController = navigationController;
    [navigationController pushViewController:mainViewController animated:NO];
    safeRelease(navigationController);
    safeRelease(mainViewController);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self prefetchSites];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
