//
//  ASMenuItem.m
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASMenuItem.h"

@implementation ASMenuItem

- (instancetype)initWithTitle:(NSString *)title name:(NSString *)name requireLogin:(BOOL)isLoginRequired {
    self = [super init];
    if (self) {
        self.title = title;
        self.isLoginRequired = isLoginRequired;
        self.name = name;
    }
    return self;
}

@end
