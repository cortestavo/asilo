//
//  AppDelegate.m
//  Asilo
//
//  Created by Octavio Cortes on 7/2/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "ASUser.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeDrawerController];
    [self initParse];
    return YES;
}

- (void)initializeDrawerController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UINavigationController *resultMapViewController = [searchStoryboard instantiateInitialViewController];
    UIViewController *menuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"Menu"];
    
    self.drawerViewController = [[MMDrawerController alloc] initWithCenterViewController:resultMapViewController leftDrawerViewController:menuViewController];
    self.drawerViewController.openDrawerGestureModeMask = MMOpenDrawerGestureModeCustom;
    self.drawerViewController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeTapCenterView;
    
    self.window.rootViewController = self.drawerViewController;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initParse {
    [Parse setApplicationId:@"47azMepKryfWJSRJQYsGW93O2r3ltrn6QYPscHR8"
                  clientKey:@"tp8yTvbgtJwbeN2FLRyqYxQQk6ZUZIGL8UNc59af"];
}

@end
