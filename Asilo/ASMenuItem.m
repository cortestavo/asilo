//
//  ASMenuItem.m
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASMenuItem.h"

@implementation ASMenuItem

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)selectItem {
    NSException *exception = [NSException exceptionWithName:@"Not implemented" reason:@"This method should be implemented by the subclass" userInfo:nil];
    @throw exception;
}

@end
