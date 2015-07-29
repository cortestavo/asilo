//
//  LoginHelper.m
//  Asilo
//
//  Created by Octavio Cortes on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "LoginHelper.h"
#import "LoginViewController.h"

@implementation LoginHelper

+ (void) displayLoginFromViewController:(UIViewController *)sourceViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *navigationViewController = (UINavigationController *)[storyboard instantiateInitialViewController];
    
    [sourceViewController presentViewController:navigationViewController animated:YES completion:^{
        
    }];
}

+ (void) displayLoginFromViewController:(UIViewController *)sourceViewController block:(void(^)())block {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *navigationViewController = (UINavigationController *)[storyboard instantiateInitialViewController];
    LoginViewController *loginViewController = (LoginViewController *)navigationViewController.viewControllers[0];
    
    loginViewController.block = block;
    
    [sourceViewController presentViewController:navigationViewController animated:YES completion:^{
    }];

}

@end
