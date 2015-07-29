//
//  ResultListTableViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultListTableViewController.h"
#import "ResultListTableViewCell.h"
#import "ASHome.h"
#import "HomeDetailViewController.h"

@interface ResultListTableViewController ()

@end

@implementation ResultListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment to include a test home ==================
//    ASHome *testHome = [ASHome object];
//    testHome.priceForRent = @3500;
//    testHome.isForRent = YES;
//    testHome.beds = @2;
//    testHome.baths = @1;
//    testHome.squareMeters = @180;
//    testHome.address = @"Blv. Fco. Eusebio Kino No. 123, Col. Pitic, Hermosillo, Sonora.";
//    self.homes = [NSArray arrayWithObject:testHome];
    // =========================================
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultListCell" forIndexPath:indexPath];
    [cell setupWithHome:self.homes[indexPath.row]];
    cell.parent = self;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ListToDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ASHome *home = self.homes[indexPath.row];
        HomeDetailViewController *destination = (HomeDetailViewController *)segue.destinationViewController;
        destination.home = home;
    }
}

@end
