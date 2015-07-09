//
//  ASMenuItem.m
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASMenuItem.h"

@implementation ASMenuItem

- (instancetype)initWithTitle:(NSString *)title requireLogin:(BOOL)isLoginRequired {
    self = [super init];
    if (self) {
        self.title = title;
        self.isLoginRequired = isLoginRequired;
    }
    return self;
}

@end
