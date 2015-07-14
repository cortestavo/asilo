//
//  LoginViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "ASUser.h"
#import "MenuViewController.h"
#import "ASMenuItem.h"
#import <MMDrawerController/MMDrawerController.h>
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([ASUser currentUser] == nil) {
        [self showOnlyLoginButton];
    } else {
        [self showOnlyLogoutLabel];
        [ASUser logOutInBackgroundWithBlock:^(NSError *error) {
            [self showOnlyLoginButton];
            [self updateLoginStatus];
            [self sendToSearch];
        }];
    }
}

- (IBAction)loginWithFacebook:(id)sender {
    [PFFacebookUtils logInInBackgroundWithReadPermissions:@[@"public_profile"] block:^(PFUser *user, NSError *error) {
        [self updateLoginStatus];
        if(user != nil) {
            [self sendToSearch];
        }
    }];
}

- (MMDrawerController *) getDrawer {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    MMDrawerController *drawerController = appDelegate.drawerViewController;
    return drawerController;
}

- (void) updateLoginStatus {
    MMDrawerController *drawer = [self getDrawer];
    MenuViewController *menu = (MenuViewController *)drawer.leftDrawerViewController;
    [menu updateLoginStatus];
}

- (void) sendToSearch {
    MMDrawerController *drawer = [self getDrawer];
    UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UIViewController *destinationViewController = [destinationStoryboard instantiateInitialViewController];
    [drawer setCenterViewController:destinationViewController withCloseAnimation:NO completion:nil];
}

- (void) showOnlyLoginButton {
    [self.loggingOutLabel setHidden:YES];
    [self.loginFacebookButton setHidden:NO];
}

- (void) showOnlyLogoutLabel {
    [self.loggingOutLabel setHidden:NO];
    [self.loginFacebookButton setHidden:YES];
}

@end
