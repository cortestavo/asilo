//
//  ResultListTableViewCell.m
//  Asilo
//
//  Created by Javier Rosas on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultListTableViewCell.h"
#import <NSDate+DateTools.h>
#import "ASUser.h"

@interface ResultListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (nonatomic) ASHome *home;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

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
    self.home = home;
    ASUser *currentUser = [ASUser currentUser];
    if(currentUser != nil) {
        PFQuery *query = [PFQuery queryWithClassName:@"_User"];
        [query whereKey:@"favorites" equalTo:home];
        [query countObjectsInBackgroundWithBlock:^(int counter, NSError *error){
            if(counter > 0) {
                [self favorite];
            }
        }];
    }
}

- (IBAction)favoriteAction:(id)sender {
    ASUser *currentUser = [ASUser currentUser];
    if(currentUser != nil) {
        if(self.home.isFavorite == true) {
            [currentUser unfavorite:self.home block:^{
                [self unfavorite];
            }];
        } else {
            [currentUser favorite:self.home block:^{
                [self favorite];
            }];
        }
    }
}

- (void) favorite {
    [self changeTitleToFavoriteButton:@"Favorited!!"];
    self.home.isFavorite = true;
}

- (void) unfavorite {
    [self changeTitleToFavoriteButton:@"Favorite"];
    self.home.isFavorite = false;
}

- (void) changeTitleToFavoriteButton:(NSString *)newTitle {
    [self.favoriteButton setTitle:newTitle forState:UIControlStateNormal];
    [self.favoriteButton layoutIfNeeded];
}

@end
