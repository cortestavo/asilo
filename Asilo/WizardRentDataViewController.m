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
#import "ASAlertHelper.h"
#import <MBProgressHUD.h>

@interface WizardRentDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceForRentField;
@property (weak, nonatomic) IBOutlet UITextField *depositField;
@property (weak, nonatomic) IBOutlet UILabel *monthsForLeaseLabel;
@property (weak, nonatomic) IBOutlet UIStepper *monthsForLeaseStepper;
@property (weak, nonatomic) IBOutlet UISwitch *furnishedSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *petsAllowedSwitch;

@property (assign, nonatomic) BOOL isSaving;

@end

@implementation WizardRentDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    if(self.home.objectId != nil) {
        [self initFromHome];
    }
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Rent info";
    NSString *nextString = self.home.isForSale ? @"Next" : @"Save";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nextString style:UIBarButtonItemStyleDone target:self action:@selector(next)];
}

- (BOOL)populateModel {
    double priceForRent = [self.priceForRentField.text doubleValue];
    if (priceForRent <= 0) {
        [ASAlertHelper alertWithTitle:@"Validation error" message:@"Please set a positive price for rent" sourceViewController:self];
        return NO;
    }
    self.home.priceForRent = @([self.priceForRentField.text doubleValue]);
    self.home.deposit = @([self.depositField.text doubleValue]);
    self.home.lease = @((long)self.monthsForLeaseStepper.value);
    self.home.isFurnished = self.furnishedSwitch.isOn;
    self.home.petsAllowed = self.petsAllowedSwitch.isOn;
    return YES;
}

- (void) initFromHome {
    ASHome *home = self.home;
    self.priceForRentField.text = [home.priceForRent stringValue];
    self.depositField.text = [home.deposit stringValue];
    self.monthsForLeaseStepper.value = [home.lease doubleValue];
    self.monthsForLeaseLabel.text = [NSString stringWithFormat:@"%lu months", (long)self.monthsForLeaseStepper.value];
    self.furnishedSwitch.on = home.isFurnished;
    self.petsAllowedSwitch.on = home.petsAllowed;
}

- (void)next {
    if ([self populateModel]) {
        if (self.home.isForSale) {
            [self performSegueWithIdentifier:@"WizardRentToSale" sender:nil];
        } else {
            [self saveHome];
        }
    }
}

- (void)saveHome {
    if (self.isSaving) {
        return;
    }
    if (![self populateModel]) {
        return;
    }
    self.isSaving = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Saving...";
    [self.home saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.isSaving = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (succeeded) {
            [self dismissViewControllerAnimated:YES completion:nil]; // Closes modal
        } else {
            [ASAlertHelper alertWithTitle:@"Validation error" message:error.localizedDescription sourceViewController:self];
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
