//
//  MenuViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "MenuViewController.h"
#import "ASNavigateMenuItem.h"
#import "ASLoginMenuItem.h"
#import "AppDelegate.h"
#import "SearchNavigationController.h"
#import <Parse/Parse.h>
#import "ASUser.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuItems = @[
                       [[ASNavigateMenuItem alloc] initWithTitle:@"For Rent" requireLogin:NO destination:@"Search" beforeNavigation:^(UIViewController *destinationViewController) {
                           SearchNavigationController *searchNavigation = (SearchNavigationController *)destinationViewController;
                           searchNavigation.searchType = ASFilterTypeForRent;
                       }],
                       [[ASNavigateMenuItem alloc] initWithTitle:@"For Sale" requireLogin:NO destination:@"Search" beforeNavigation:^(UIViewController *destinationViewController) {
                           SearchNavigationController *searchNavigation = (SearchNavigationController *)destinationViewController;
                           searchNavigation.searchType = ASFilterTypeForSale;
                       }],
                       [[ASNavigateMenuItem alloc] initWithTitle:@"My publications" requireLogin:YES destination:@"Publications" beforeNavigation:nil],
                      [[ASLoginMenuItem alloc] initWithTitle:@"Log in" sourceViewController:self],
                      [[ASNavigateMenuItem alloc] initWithTitle:@"Settings" requireLogin:NO destination:@"Settings" beforeNavigation:nil],
                       ];
    [self updateLoginStatus];
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

#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    ASMenuItem *item = self.menuItems[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASMenuItem *item = self.menuItems[indexPath.row];
    [item selectItem];
}

- (void) updateLoginStatus {
    NSString *loginTitle = @"Log in";
    if([ASUser currentUser]) {
        loginTitle = @"Log out";
    }
    [self.menuItems[3] setTitle:loginTitle];
    [self.menuItemsTable reloadData];
}

@end
