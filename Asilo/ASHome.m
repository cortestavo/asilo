//
//  Home.m
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASHome.h"
#import <Parse/PFObject+Subclass.h>

@implementation ASHome

@dynamic address;           // shared
@dynamic baths;             // shared
@dynamic beds;              // shared
@dynamic deposit;           // rent
@dynamic homeDescription;   // shared
@dynamic hasAC;             // shared
@dynamic hasHeating;        // shared
@dynamic isForSale;         // NA
@dynamic isForRent;         // NA
@dynamic isFurnished;       // rent
@dynamic lease;             // rent
@dynamic location;          // NA
@dynamic owner;             // NA
@dynamic parkingLots;       // shared
@dynamic petsAllowed;       // rent
@dynamic priceForRent;      // rent
@dynamic priceForSale;      // sale
@dynamic squareMeters;      // shared
@dynamic tags;              // shared

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Home";
}

@end
