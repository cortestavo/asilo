//
//  Filter.h
//  Asilo
//
//  Created by Octavio Cortes on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>
@class ASUser;

@interface ASFilter : PFObject <PFSubclassing>

typedef enum {
    ASSearchTypeForRent,
    ASSearchTypeForSale
} ASFilterType;

@property (nonatomic) NSNumber *baths;
@property (nonatomic) NSNumber *beds;
@property (nonatomic) BOOL emailNotification;
@property (nonatomic) BOOL hasAC;
@property (nonatomic) BOOL hasHeating;
@property (nonatomic) BOOL isFurnished;
@property (nonatomic) NSNumber *maxLease;
@property (nonatomic) NSNumber *maxPrice;
@property (nonatomic) NSNumber *minPrice;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PFGeoPoint *northEast;
@property (nonatomic) PFGeoPoint *southWest;
@property (nonatomic) ASUser *owner;
@property (nonatomic) NSNumber *parkingLots;
@property (nonatomic) BOOL petsAllowed;
@property (nonatomic) ASFilterType type;


+ (NSString *)parseClassName;

@end
