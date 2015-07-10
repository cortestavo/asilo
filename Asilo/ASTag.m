//
//  Tag.m
//  Asilo
//
//  Created by Octavio Cortes on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASTag.h"
#import <Parse/PFObject+Subclass.h>

@implementation ASTag

@dynamic name;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Tag";
}

@end
