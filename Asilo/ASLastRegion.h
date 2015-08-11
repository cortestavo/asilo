//
//  ASLastRegion.h
//  Asilo
//
//  Created by Octavio Cortes on 8/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface ASLastRegion : NSObject

@property (nonatomic) MKCoordinateRegion region;

+ (void) setRegion:(MKCoordinateRegion)region;
+ (MKCoordinateRegion) getRegion;
    
@end
