//
//  MenuViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "MenuViewController.h"
#import "ASMenuItem.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.menuItems = @[
                       [[ASMenuItem alloc] initWithTitle:@"For Rent" name:@"Search" requireLogin:NO],
                       [[ASMenuItem alloc] initWithTitle:@"For Sale" name:@"Search" requireLogin:NO],
                       [[ASMenuItem alloc] initWithTitle:@"My publications" name:@"Publications" requireLogin:NO],
                       [[ASMenuItem alloc] initWithTitle:@"Log in" name:@"Login" requireLogin:NO],
                       [[ASMenuItem alloc] initWithTitle:@"Log out" name:@"logout" requireLogin:NO],
                       [[ASMenuItem alloc] initWithTitle:@"Settings" name:@"Settings" requireLogin:NO]
                       ];
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:item.name bundle:nil];
    UIViewController *destinationViewController = [destinationStoryboard instantiateInitialViewController];
    [appDelegate.drawerViewController setCenterViewController:destinationViewController withCloseAnimation:YES completion:nil];
}

@end
