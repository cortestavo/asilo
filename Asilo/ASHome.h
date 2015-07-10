//
//  Home.h
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>
@class PFGeoPoint;
@class ASUser;

@interface ASHome : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *address;
@property (nonatomic) NSNumber *baths;
@property (nonatomic) NSNumber *beds;
@property (nonatomic) NSNumber *deposit;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) BOOL hasAC;
@property (nonatomic) BOOL hasHeating;
@property (nonatomic) BOOL isForSale;
@property (nonatomic) BOOL isForRent;
@property (nonatomic) BOOL isFurnished;
@property (nonatomic) NSNumber *lease;
@property (nonatomic) PFGeoPoint *location;
@property (nonatomic) ASUser *owner;
@property (nonatomic) NSNumber *parkingLots;
@property (nonatomic) BOOL petsAllowed;
@property (nonatomic) NSNumber *priceForRent;
@property (nonatomic) NSNumber *priceForSale;
@property (nonatomic) NSNumber *squareMeters;
@property (nonatomic) PFRelation *tags;

+ (NSString *)parseClassName;

@end
