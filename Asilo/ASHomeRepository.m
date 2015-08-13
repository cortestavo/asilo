//
//  ASHomeRepository.m
//  Asilo
//
//  Created by Octavio Cortes on 7/16/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASHomeRepository.h"
#import "ASHome.h"

@implementation ASHomeRepository

+ (void) findUsingFilterWithBlock:(ASFilter *)filter block:(void (^)(NSArray *homes))block {
    PFQuery *query = [self createQuery];
    NSString *priceField;
    NSNumber *minPrice = [filter.minPrice floatValue] >= 0 ? filter.minPrice : @(0);
    NSNumber *maxPrice = [filter.maxPrice floatValue] >= 0 ? filter.maxPrice : @(0);
    
    if(filter.type == ASFilterTypeForRent) {
        [query whereKey:@"isForRent" equalTo:@YES];
        priceField = @"priceForRent";
    } else {
        [query whereKey:@"isForSale" equalTo:@YES];
        priceField = @"priceForSale";
    }
    [query whereKey:@"location" withinGeoBoxFromSouthwest:filter.southWest toNortheast:filter.northEast];
    [query whereKey:priceField greaterThanOrEqualTo:minPrice];
    if([maxPrice doubleValue] > [minPrice doubleValue]) {
        [query whereKey:priceField lessThanOrEqualTo:maxPrice];
    }
    [query findObjectsInBackgroundWithBlock:^(NSArray *homes, NSError *error){
        NSArray *found = [NSArray arrayWithArray:homes];
        block(found);
    }];
}

+ (void)getPublishedHomesForUser:(PFUser *)user block:(void (^)(NSArray *, NSError *))block {
    PFQuery *query = [self createQuery];
    [query whereKey:@"owner" equalTo:user];
    [query findObjectsInBackgroundWithBlock:block];
}

#pragma private methods

/**
    Returns the right query for Homes
 **/
+ (PFQuery *) createQuery {
    return [PFQuery queryWithClassName:@"Home"];
}

@end
