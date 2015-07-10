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

@dynamic address;
@dynamic baths;
@dynamic beds;
@dynamic deposit;
@dynamic description;
@dynamic hasAC;
@dynamic hasHeating;
@dynamic isForSale;
@dynamic isForRent;
@dynamic isFurnished;
@dynamic lease;
@dynamic location;
@dynamic owner;
@dynamic parkingLots;
@dynamic petsAllowed;
@dynamic priceForRent;
@dynamic priceForSale;
@dynamic squareMeters;
@dynamic tags;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Home";
}

@end
