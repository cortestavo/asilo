//
//  ASLastFilter.m
//  Asilo
//
//  Created by Octavio Cortes on 8/12/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASLastFilter.h"

@implementation ASLastFilter

+ (void) setFilter:(ASFilter *)filter key:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *lastFilter = @{
        @"type": @(filter.type),
        @"minPrice": filter.minPrice,
        @"maxPrice": filter.maxPrice,
        @"northEast": @{
            @"latitude": @(filter.northEast.latitude),
            @"longitude": @(filter.northEast.longitude)
        },
        @"southWest": @{
                @"latitude": @(filter.southWest.latitude),
                @"longitude": @(filter.southWest.longitude)
        }
    };
    [defaults setObject:lastFilter forKey:key];
}

+ (ASFilter *) getFilterByKey:(NSString *)key {
    ASFilter *filter = [ASFilter getNewObject];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *lastFilterDictionary = [defaults objectForKey:key];

    if(lastFilterDictionary == nil) {
        if([key isEqualToString:@"lastRentFilter"] == true) {
            filter.type = ASFilterTypeForRent;
        } else {
            filter.type = ASFilterTypeForSale;
        }
        filter.minPrice = @0;
        filter.maxPrice = @0;
        filter.northEast = [PFGeoPoint geoPoint];
        filter.southWest = [PFGeoPoint geoPoint];
    } else {
        filter.type = [lastFilterDictionary[@"type"] intValue];
        filter.minPrice = lastFilterDictionary[@"minPrice"];
        filter.maxPrice = lastFilterDictionary[@"maxPrice"];
        filter.northEast.latitude = [lastFilterDictionary[@"northEast"][@"latitude"] floatValue];
        filter.northEast.longitude = [lastFilterDictionary[@"northEast"][@"longitude"] floatValue];
        filter.southWest.latitude = [lastFilterDictionary[@"southWest"][@"latitude"] floatValue];
        filter.southWest.longitude = [lastFilterDictionary[@"southWest"][@"longitude"] floatValue];
    }
    return filter;
}

+ (ASFilter *) getRentFilter {
    return [self getFilterByKey:@"lastRentFilter"];
}

+ (ASFilter *) getSaleFilter {
    return [self getFilterByKey:@"lastSaleFilter"];
}

+ (void) setRentFilter:(ASFilter *)filter {
    [self setFilter:filter key:@"lastRentFilter"];
}

+ (void) setSaveFilter:(ASFilter *)filter {
    [self setFilter:filter key:@"lastSaleFilter"];
}

@end
