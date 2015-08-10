//
//  HomeTableViewController.m
//  Asilo
//
//  Created by Octavio Cortes on 8/5/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "HomeTableViewController.h"
#import "ASUser.h"
#import "ASHomeRepository.h"
#import <MMDrawerBarButtonItem.h>
#import "AppDelegate.h"

@interface HomeTableViewController ()
@end

@implementation HomeTableViewController

- (instancetype)initWithHomes:(NSArray *)homes
{
    self = [super init];
    if (self) {
        self.homes = homes;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.useMenuItem == true) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:200/255.0 alpha:1];
        MMDrawerBarButtonItem *menuButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(showMenu:)];
        self.navigationItem.leftBarButtonItem = menuButton;
        menuButton.tintColor = [UIColor whiteColor];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeCell"];
}

- (void)showMenu:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.drawerViewController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homes.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  266.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    [cell setupWithHome:self.homes[indexPath.row]];
    cell.parent = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showDetailForHome:self.homes[indexPath.row]];
}

- (void)showDetailForHome:(ASHome *)home {
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    HomeDetailViewController *vc = (HomeDetailViewController *)[searchStoryboard instantiateViewControllerWithIdentifier:@"HomeDetail"];
    vc.home = home;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
