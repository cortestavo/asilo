//
//  ASHomeRepository.h
//  Asilo
//
//  Created by Octavio Cortes on 7/16/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "ASFilter.h"

@interface ASHomeRepository : NSObject 

+ (void) findByAreaWithNorthEast:(CLLocationCoordinate2D)northEastPoint southWest:(CLLocationCoordinate2D)southWestPoint searchType:(ASFilterType)searchType block:(void (^)(NSArray *homes))block;

+ (void)getPublishedHomesForUser:(PFUser *)user block:(void (^)(NSArray *homes, NSError *error))block;

@end
