//
//  ASMenuViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASBaseViewController.h"
#import "AppDelegate.h"
#import <MMDrawerBarButtonItem.h>

@interface ASBaseViewController ()

@end

@implementation ASBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:200/255.0 alpha:1];
    MMDrawerBarButtonItem *menuButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = menuButton;
    menuButton.tintColor = [UIColor whiteColor];
}

#pragma mark - Menu

- (void)showMenu:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.drawerViewController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
