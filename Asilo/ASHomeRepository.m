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

+ (void) findByAreaWithNorthEast:(CLLocationCoordinate2D)northEastPoint southWest:(CLLocationCoordinate2D)southWestPoint searchType:(ASFilterType)searchType block:(void (^)(NSArray *homes))block {
    PFQuery *query = [self createQuery];
    PFGeoPoint *ne = [PFGeoPoint geoPointWithLatitude:northEastPoint.latitude longitude:northEastPoint.longitude];
    PFGeoPoint *sw = [PFGeoPoint geoPointWithLatitude:southWestPoint.latitude longitude:southWestPoint.longitude];
    if(searchType == ASFilterTypeForRent) {
        [query whereKey:@"isForRent" equalTo:@YES];
    } else {
        [query whereKey:@"isForSale" equalTo:@YES];
    }
    [query whereKey:@"location" withinGeoBoxFromSouthwest:sw toNortheast:ne];
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
