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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Menu

- (void)showMenu:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.drawerViewController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
