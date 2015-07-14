//
//  WizardTypeViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardSharedDataViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     if (segue.identifier isEqualToString:@"Wizard")
}
*/

@end
