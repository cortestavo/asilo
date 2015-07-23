//
//  WizardTypeViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardSharedDataViewController.h"
#import "WizardRentDataViewController.h"
#import "WizardSaleDataViewController.h"

@interface WizardSharedDataViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *forRentSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *forSaleSwitch;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBathsLabel;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfBathsStepper;
@property (weak, nonatomic) IBOutlet UILabel *numberOfBedsLabel;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfBedsStepper;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UISwitch *hasAcSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *hasHeatingSwitch;
@property (weak, nonatomic) IBOutlet UILabel *numberOfParkingLotsLabel;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfParkingLotsStepper;
@property (weak, nonatomic) IBOutlet UITextField *squareFeetField;

@end

@implementation WizardSharedDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUiElements];
    [self setupNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUiElements {
    self.descriptionText.text = @"";
    self.descriptionText.layer.borderColor = [UIColor colorWithRed:230.0/255.0
                                                             green:230.0/255.0
                                                              blue:230.0/255.0
                                                             alpha:1.0].CGColor;
    self.descriptionText.layer.borderWidth = 1;
    self.descriptionText.layer.cornerRadius = 5;
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"General info";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
}

- (void)next {
    if ([self populateModel]) {
        if (self.forRentSwitch.isOn) {
            [self performSegueWithIdentifier:@"WizardSharedToRent" sender:nil];
        } else {
            [self performSegueWithIdentifier:@"WizardSharedToSale" sender:nil];
        }
    } else {
        // TODO: Alert error
    }
}

- (BOOL)populateModel {
    if ([self.addressField.text isEqualToString:@""]) {
        return NO;
    }
    self.home.isForRent = self.forRentSwitch.isOn;
    self.home.isForSale = self.forSaleSwitch.isOn;
    self.home.address = self.addressField.text;
    self.home.homeDescription = self.descriptionText.text;
    self.home.baths = @(self.numberOfBathsStepper.value);
    self.home.beds = @(self.numberOfBedsStepper.value);
    self.home.parkingLots = @(self.numberOfParkingLotsStepper.value);
    self.home.squareMeters = @([self.squareFeetField.text doubleValue]);
    self.home.hasAC = self.hasAcSwitch.isOn;
    self.home.hasHeating = self.hasHeatingSwitch.isOn;
    return YES;
}

- (IBAction)forRentSwitchChanged:(id)sender {
    UISwitch *forRentSwitch = (UISwitch *)sender;
    if (!forRentSwitch.isOn) {
        self.forSaleSwitch.on = true;
    }
}

- (IBAction)forSaleSwitchChanged:(id)sender {
    UISwitch *forSaleSwitch = (UISwitch *)sender;
    if (!forSaleSwitch.isOn) {
        self.forRentSwitch.on = true;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WizardSharedToRent"]) {
        WizardRentDataViewController *rentVC = (WizardRentDataViewController *)segue.destinationViewController;
        rentVC.home = self.home;
    } else if ([segue.identifier isEqualToString:@"WizardSharedToSale"]) {
        WizardSaleDataViewController *saleVC = (WizardSaleDataViewController *)segue.destinationViewController;
        saleVC.home = self.home;
    }
}

#pragma mark - View handlers

- (IBAction)numberOfBathsChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.numberOfBathsLabel.text = [NSString stringWithFormat:@"%lu",(long)stepper.value];
}

- (IBAction)numberOfBedsChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.numberOfBedsLabel.text = [NSString stringWithFormat:@"%lu",(long)stepper.value];
}

- (IBAction)numberOfParkingLotsChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.numberOfParkingLotsLabel.text = [NSString stringWithFormat:@"%lu",(long)stepper.value];
}

@end
