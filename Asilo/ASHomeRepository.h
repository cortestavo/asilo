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

+ (void) findUsingFilterWithBlock:(ASFilter *)filter block:(void (^)(NSArray *homes))block;

+ (void)getPublishedHomesForUser:(PFUser *)user block:(void (^)(NSArray *homes, NSError *error))block;

@end
