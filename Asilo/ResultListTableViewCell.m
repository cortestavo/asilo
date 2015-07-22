//
//  ResultListTableViewCell.m
//  Asilo
//
//  Created by Javier Rosas on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultListTableViewCell.h"
#import <NSDate+DateTools.h>

@interface ResultListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *gradientView;

@end

@implementation ResultListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setupGradient];
}

-(void)setupGradient {
    UIColor *dark = [UIColor blackColor];
    UIColor *transparent = [UIColor clearColor];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.colors = @[(id)[transparent CGColor], (id)[dark CGColor]];
    self.gradientView.backgroundColor = transparent;
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setupWithHome:(ASHome *)home {
    NSNumberFormatter *currencyFormatter = [NSNumberFormatter new];
    currencyFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    currencyFormatter.maximumFractionDigits = 2;
    NSNumberFormatter *distanceFormatter = [NSNumberFormatter new];
    distanceFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    distanceFormatter.maximumFractionDigits = 2;
    if (home.isForRent) {
        self.priceLabel.text = [NSString stringWithFormat:@"$%@/mo", [currencyFormatter stringFromNumber:home.priceForRent]];
    } else {
        self.priceLabel.text = [NSString stringWithFormat:@"$%@", [currencyFormatter stringFromNumber:home.priceForSale]];
    }
    self.summaryLabel.text = [NSString stringWithFormat:@"%d bd, %d bth, %@ sqmt", home.beds.intValue, home.baths.intValue, [distanceFormatter stringFromNumber:home.squareMeters]];
    self.addressLabel.text = home.address;
    self.dateLabel.text = home.createdAt.timeAgoSinceNow;
}

@end
