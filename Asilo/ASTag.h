//
//  Tag.h
//  Asilo
//
//  Created by Octavio Cortes on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>

@interface ASTag : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *name;

+ (NSString *)parseClassName;

@end
