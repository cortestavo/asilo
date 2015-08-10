//
//  ASNavigateMenuItem.m
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASNavigateMenuItem.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@implementation ASNavigateMenuItem

-(instancetype)initWithTitle:(NSString *)title requireLogin:(BOOL)isLoginRequired destination:(NSString *)destination beforeNavigation:(void (^)(UIViewController *))beforeNavigation
{
    self = [super initWithTitle:title];
    if (self) {
        self.destination = destination;
        self.beforeNavigation = beforeNavigation;
        self.requireLogin = isLoginRequired;
    }
    return self;
}

-(void)selectItem {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *destinationViewController = [self getViewController];
    
    if([self hasLoginPassed]) {
        if (self.beforeNavigation) {
            self.beforeNavigation(destinationViewController);
        }
        [appDelegate.drawerViewController setCenterViewController:destinationViewController withCloseAnimation:YES completion:nil];
    }
}

- (UIViewController *)getViewController {
    UIStoryboard *destinationStoryboard;
    UIViewController *destinationViewController;
    
    destinationStoryboard = [UIStoryboard storyboardWithName:self.destination bundle:nil];
    destinationViewController = [destinationStoryboard instantiateInitialViewController];
    return destinationViewController;
}

@end
