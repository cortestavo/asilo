//
//  ResultMapViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultMapViewController.h"
#import "ResultListTableViewController.h"

@interface ResultMapViewController ()

@end

@implementation ResultMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

-(void)changeToListView {
    [self performSegueWithIdentifier:@"ResultList" sender:nil];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultList"]) {
        ResultListTableViewController *listView = (ResultListTableViewController *)segue.destinationViewController;
        #warning Missing implementation
        // TODO: Set a value to the listView.homes array
    }
}

@end
