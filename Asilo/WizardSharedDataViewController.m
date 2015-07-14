//
//  WizardTypeViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardSharedDataViewController.h"

@interface WizardSharedDataViewController ()

@end

@implementation WizardSharedDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"General info";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
}

- (void)next {
    [self performSegueWithIdentifier:@"WizardSharedToRent" sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
<<<<<<< HEAD
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
=======
//     if (segue.identifier isEqualToString:@"Wizard")
>>>>>>> change name of VC
}
*/

@end
