//
//  User.m
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASUser.h"
#import "ASHomeRepository.h"

@implementation ASUser

@dynamic favorites;
@dynamic picture;

+ (void)load {
    [self registerSubclass];
}

+ (ASUser *)currentUser {
    return (ASUser *)[PFUser currentUser];
}

- (void)getMyPublicationsWithBlock:(void(^)(NSArray *, NSError *))block {
    [ASHomeRepository getPublishedHomesForUser:self block:block];
}

@end
