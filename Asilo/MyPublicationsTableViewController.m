//
//  MyPublicationsTableViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "MyPublicationsTableViewController.h"
#import "ASHomeRepository.h"
#import "HomeTableViewController.h"
#import "ASUser.h"

@interface MyPublicationsTableViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) NSArray *homes;
@property (weak, nonatomic) HomeTableViewController *home;

@end

@implementation MyPublicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(publishNew)];
    [self createHomesTable];
}

- (void)createHomesTable {
    UIStoryboard *destinationStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UINavigationController *nav = (UINavigationController *)[destinationStoryboard instantiateViewControllerWithIdentifier:@"HomeTable"];
    self.home = nav.viewControllers[0];
    [self loadPublishedHomes];
    [self addChildViewController:self.home];
    self.home.view.frame = self.containerView.frame;
    [self.containerView addSubview:self.home.view];
    [self.home didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadPublishedHomes];
}

- (void) loadPublishedHomes {
    [ASHomeRepository getPublishedHomesForUser:[ASUser currentUser] block:^(NSArray *homes, NSError *error) {
        if(error == nil) {
            self.home.homes = homes;
            [self.home.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

-(void)publishNew {
    [self performSegueWithIdentifier:@"PublishWizard" sender:nil];
}

@end
