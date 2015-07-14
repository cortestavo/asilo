//
//  WizardRentDataViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/13/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardRentDataViewController.h"

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
    // Do any additional setup after loading the view.
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

@end
