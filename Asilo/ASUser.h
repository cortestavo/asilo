//
//  User.h
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>
@class ASHome;

@interface ASUser : PFUser

@property (nonatomic, strong) PFRelation *favorites;
@property (nonatomic, strong) PFFile *picture;

+ (ASUser *)currentUser;
- (void) getFavoritesWithBlock:(void (^)(NSMutableArray *))block;
- (void) favorite:(ASHome *)home block:(void (^)())block;
- (void) unfavorite:(ASHome *)home block:(void (^)())block;

- (void)getMyPublicationsWithBlock:(void(^)(NSArray *homes, NSError *error))block;

@end
