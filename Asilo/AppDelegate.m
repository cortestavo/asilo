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
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];
    [self initParse: launchOptions];
    [self initializeDrawerController];
    return YES;
}

- (void)initializeDrawerController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UINavigationController *resultMapViewController = [searchStoryboard instantiateInitialViewController];
    UIViewController *menuViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"Menu"];
    
    self.drawerViewController = [[MMDrawerController alloc] initWithCenterViewController:resultMapViewController leftDrawerViewController:menuViewController];
    self.drawerViewController.openDrawerGestureModeMask = MMOpenDrawerGestureModeCustom;
    self.drawerViewController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    self.window.rootViewController = self.drawerViewController;
    [self.window makeKeyAndVisible];
}

- (void)initParse:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"47azMepKryfWJSRJQYsGW93O2r3ltrn6QYPscHR8"
                  clientKey:@"tp8yTvbgtJwbeN2FLRyqYxQQk6ZUZIGL8UNc59af"];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance]
        application:application
        openURL:url
        sourceApplication:sourceApplication
        annotation:annotation
    ];
}
@end
