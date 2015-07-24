//
//  WizardSaleDataViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/13/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardSaleDataViewController.h"
#import "ASAlertHelper.h"

@interface WizardSaleDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceForSaleField;

@end

@implementation WizardSaleDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Sale info";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveHome)];
}

- (BOOL)populateModel {
    double priceForSale = [self.priceForSaleField.text doubleValue];
    if (priceForSale > 0) {
        self.home.priceForSale = @(priceForSale);
        return YES;
    } else {
        [ASAlertHelper alertWithTitle:@"Validation error" message:@"Please set a positive price for rent" sourceViewController:self];
        return NO;
    }
}

-(void)saveHome {
    if ([self populateModel]) {
        [self.home saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil]; // Closes modal
            } else {
                // TODO: Alert error
                [ASAlertHelper alertWithTitle:@"Couldn't save" message:error.localizedDescription sourceViewController:self];
            }
        }];
    }
}

@end
