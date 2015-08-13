//
//  SaveFilterViewController.m
//  Asilo
//
//  Created by Octavio Cortes on 8/11/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "SaveFilterViewController.h"
#import "ASAlertHelper.h"
#import "ASUser.h"

@interface SaveFilterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (assign) BOOL isSaving;

@end

@implementation SaveFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)saveFilter:(id)sender {
    if([self isValid] == true && self.isSaving != true) {
        self.filter.name = self.name.text;
        self.filter.owner = [ASUser currentUser];
        self.isSaving = true;
        [self.filter saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            self.isSaving = false;
            [self performSegueWithIdentifier:@"BackToMapResults" sender:self];
        }];
    } else {
        [ASAlertHelper alertWithTitle:@"Validation error" message:@"Name is required" sourceViewController:self];
    }
}
    
- (BOOL) isValid {
    BOOL isValid = true;
    
    if([self.name.text length] == 0) {
        isValid = false;
    }
    return isValid;
}

@end
