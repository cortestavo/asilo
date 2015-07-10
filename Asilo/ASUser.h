//
//  User.h
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>

@interface ASUser : PFUser

@property (nonatomic, strong) PFRelation *favorites;
@property (nonatomic, strong) PFFile *picture;

+ (ASUser *)currentUser;

@end
