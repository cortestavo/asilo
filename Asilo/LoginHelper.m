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
    LoginViewController *loginViewController = (LoginViewController *)[storyboard instantiateInitialViewController];
    
    [sourceViewController presentViewController:loginViewController animated:YES completion:^{
        
    }];
}

@end
