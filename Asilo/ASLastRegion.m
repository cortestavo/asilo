//
//  ASLastRegion.m
//  Asilo
//
//  Created by Octavio Cortes on 8/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASLastRegion.h"

@implementation ASLastRegion

+ (void) setRegion:(MKCoordinateRegion)region {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userLocation = @{
       @"latitude": @(region.center.latitude),
       @"longitude": @(region.center.longitude),
       @"latitudeDelta": @(region.span.latitudeDelta),
       @"longitudeDelta": @(region.span.longitudeDelta)
    };
    [defaults setObject:userLocation forKey:@"lastUserLocation"];
}

+ (MKCoordinateRegion) getRegion {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    MKCoordinateRegion region;
    NSDictionary *userLocation = [defaults objectForKey:@"lastUserLocation"];
    
    if(userLocation != nil) {
        region.center.latitude = [userLocation[@"latitude"] floatValue];
        region.center.longitude = [userLocation[@"longitude"] floatValue];
        region.span.latitudeDelta = [userLocation[@"latitudeDelta"] floatValue];
        region.span.longitudeDelta = [userLocation[@"longitudeDelta"] floatValue];
    } else {
        region.span.latitudeDelta = 0.25560062448431964;
        region.span.longitudeDelta = 0.19722137491075387;
        region.center.latitude = 29.0729670;
        region.center.longitude = -110.9559190;
    }
    return region;
}

@end
