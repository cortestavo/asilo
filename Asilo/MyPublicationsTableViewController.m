//
//  MyPublicationsTableViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "MyPublicationsTableViewController.h"
#import "ASUser.h"
#import "ResultListTableViewCell.h"
#import "HomeDetailViewController.h"

@interface MyPublicationsTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *homes;

@end

@implementation MyPublicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(publishNew)];
    [self refreshMyPublications];
}

- (void)refreshMyPublications {
    [[ASUser currentUser] getMyPublicationsWithBlock:^(NSArray *homes, NSError *error) {
        if (error) {
            // TODO: alert error
            NSLog(@"Error: %@", error.localizedDescription);
        }
        self.homes = [NSMutableArray arrayWithArray:homes];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshMyPublications];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.homes.count;
}

-(void)publishNew {
    [self performSegueWithIdentifier:@"PublishWizard" sender:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultListTableViewCell *cell = (ResultListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ResultListCell" forIndexPath:indexPath];
    ASHome *home = (ASHome *)self.homes[indexPath.row];
    [cell setupWithHome:home];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ASHome *home = (ASHome *)self.homes[indexPath.row];
        [home deleteInBackground];
        [self.homes removeObject:home];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
