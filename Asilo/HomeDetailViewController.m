//
//  HomeDetailViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/16/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedsAndBathsLabel;
@property (weak, nonatomic) IBOutlet UILabel *squareMetersLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicationTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *hasAcLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasHeatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingLotsLabel;
@property (weak, nonatomic) IBOutlet UIView *rentInfoView;
@property (weak, nonatomic) IBOutlet UILabel *isFurnishedLabel;
@property (weak, nonatomic) IBOutlet UILabel *petsAllowedLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositLabel;

@end

@implementation HomeDetailViewController

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
