//
//  RentFilterViewController.m
//  Asilo
//
//  Created by Octavio Cortes on 8/12/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "RentFilterViewController.h"
#import "ASLastFilter.h"

@interface RentFilterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *minPrice;
@property (weak, nonatomic) IBOutlet UITextField *maxPrice;

@end

@implementation RentFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.minPrice.text = [self.parent.filter.minPrice stringValue];
    self.maxPrice.text = [self.parent.filter.maxPrice stringValue];
}

- (IBAction)minPriceChanged:(id)sender {
    self.parent.filter.minPrice = @([self.minPrice.text floatValue]);
    [self.parent saveFilterToDevice];
}

- (IBAction)maxPriceChanged:(id)sender {
    self.parent.filter.maxPrice = @([self.maxPrice.text floatValue]);
    [self.parent saveFilterToDevice];
}
@end
