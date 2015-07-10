//
//  Filter.m
//  Asilo
//
//  Created by Octavio Cortes on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASFilter.h"
#import <Parse/PFObject+Subclass.h>

@implementation ASFilter

@dynamic baths;
@dynamic beds;
@dynamic emailNotification;
@dynamic hasAC;
@dynamic hasHeating;
@dynamic isFurnished;
@dynamic maxLease;
@dynamic maxPrice;
@dynamic minPrice;
@dynamic name;
@dynamic northEast;
@dynamic southWest;
@dynamic owner;
@dynamic parkingLots;
@dynamic petsAllowed;
@dynamic type;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Filter";
}

@end
