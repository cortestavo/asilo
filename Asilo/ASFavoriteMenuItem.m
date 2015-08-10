//
//  ASFavoriteMenuItem.m
//  Asilo
//
//  Created by Octavio Cortes on 8/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASFavoriteMenuItem.h"
#import "HomeTableViewController.h"
#import "ASUser.h"

@implementation ASFavoriteMenuItem

- (UIViewController *)getViewController {
    UIStoryboard *destinationStoryboard;
    
    destinationStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UINavigationController *nav = (UINavigationController *)[destinationStoryboard instantiateViewControllerWithIdentifier:@"HomeTable"];
    HomeTableViewController *home = nav.viewControllers[0];
    home.useMenuItem = true;
    home.title = self.title;
    [[ASUser currentUser] getFavoritesWithBlock:^(NSMutableArray *homes) {
        home.homes = homes;
        [home.tableView reloadData];
    }];

    return nav;
}

@end
