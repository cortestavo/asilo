//
//  ResultListTableViewCell.m
//  Asilo
//
//  Created by Javier Rosas on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "HomeTableViewCell.h"
#import <NSDate+DateTools.h>
#import "ASUser.h"
#import "LoginHelper.h"

@interface HomeTableViewCell()


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
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

- (void)setupWithHome:(ASHome *)home {
    self.favoriteButton.selected = false;
    
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
        [query whereKey:@"username" equalTo:[ASUser currentUser].username];
        [query whereKey:@"favorites" equalTo:home];
        [query countObjectsInBackgroundWithBlock:^(int counter, NSError *error){
            if(counter > 0) {
                [self favorite];
            }
        }];
    }
    if([self.home countOfPhotos] > 0) {
        [self.home getPhotoAtIndex:0 block:^(UIImage *image) {
            [self.backgroundImage setImage: image];
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
    } else {
        [LoginHelper displayLoginFromViewController:self.parent block:^{
            ASUser *currentUser = [ASUser currentUser];
            if(currentUser != nil) {
                [currentUser favorite:self.home block:^{
                    [self favorite];
                }];
            }
        }];
    }
}

- (void) favorite {
    self.favoriteButton.selected = true;
    self.home.isFavorite = true;
}

- (void) unfavorite {
    self.favoriteButton.selected = false;
    self.home.isFavorite = false;
}

@end
