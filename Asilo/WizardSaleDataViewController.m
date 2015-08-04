//
//  WizardSaleDataViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/13/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardSaleDataViewController.h"
#import "ASAlertHelper.h"
#import <MBProgressHUD.h>

@interface WizardSaleDataViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceForSaleField;
@property (assign, nonatomic) BOOL isSaving;

@end

@implementation WizardSaleDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    if(self.home.objectId != nil) {
        [self initFromHome];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Sale info";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(saveHome)];
}

- (void) initFromHome {
    self.priceForSaleField.text = [self.home.priceForSale stringValue];
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
    if (self.isSaving) {
        return;
    }
    if ([self populateModel]) {
        self.isSaving = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Saving...";
        [self.home saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            self.isSaving = NO;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
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
