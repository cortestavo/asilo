//
//  WizardRentDataViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/13/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardRentDataViewController.h"
#import "WizardSaleDataViewController.h"
#import "ASHome.h"

@interface WizardRentDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceForRentField;
@property (weak, nonatomic) IBOutlet UITextField *depositField;
@property (weak, nonatomic) IBOutlet UILabel *monthsForLeaseLabel;
@property (weak, nonatomic) IBOutlet UIStepper *monthsForLeaseStepper;
@property (weak, nonatomic) IBOutlet UISwitch *furnishedSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *petsAllowedSwitch;

@end

@implementation WizardRentDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Rent info";
    NSString *nextString = self.home.isForSale ? @"Next" : @"Save";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nextString style:UIBarButtonItemStyleDone target:self action:@selector(next)];
}

- (BOOL)populateModel {
    double priceForRent = [self.priceForRentField.text doubleValue];
    if (!priceForRent > 0)
        return NO;
    self.home.priceForRent = @([self.priceForRentField.text doubleValue]);
    self.home.deposit = @([self.depositField.text doubleValue]);
    self.home.lease = @((long)self.monthsForLeaseStepper.value);
    self.home.isFurnished = self.furnishedSwitch.isOn;
    self.home.petsAllowed = self.petsAllowedSwitch.isOn;
    return YES;
}

- (void)next {
    if ([self populateModel]) {
        if (self.home.isForSale) {
            [self performSegueWithIdentifier:@"WizardRentToSale" sender:nil];
        } else {
            [self saveHome];
        }
    } else {
        // TODO: Alert validation error
    }
}

- (void)saveHome {
    [self.home saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil]; // Closes modal
        } else {
            // TODO: Alert error
        }
    }];
}

- (IBAction)monthsForLeaseChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.monthsForLeaseLabel.text = [NSString stringWithFormat:@"%lu months", (long)stepper.value];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WizardRentToSale"]) {
        WizardSaleDataViewController *saleVC = (WizardSaleDataViewController *)segue.destinationViewController;
        saleVC.home = self.home;
    }
}

@end
