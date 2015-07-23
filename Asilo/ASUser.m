//
//  User.m
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASUser.h"
#import "ASHomeRepository.h"
#import "ASHome.h"

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

- (void) getFavoritesWithBlock:(void (^)(NSMutableArray *))block {
    PFRelation *favoritesRelation = [self relationForKey:@"favorites"];
    PFQuery *favoritesQuery = [favoritesRelation query];
    [favoritesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(objects == nil) {
            objects = [NSArray array];
        }
    }];
}

- (void) favorite:(ASHome *)home block:(void (^)())block {
    PFRelation *favoritesRelation = [self relationForKey:@"favorites"];
    [favoritesRelation addObject:home];
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        block();
    }];
}

- (void) unfavorite:(ASHome *)home block:(void (^)())block {
    PFRelation *favoritesRelation = [self relationForKey:@"favorites"];
    [favoritesRelation removeObject:home];
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        block();
    }];
}

@end
