//
//  ASNavigateMenuItem.h
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASMenuItem.h"
#import <UIKit/UIKit.h>

@interface ASNavigateMenuItem : ASMenuItem

@property (strong, nonatomic) NSString *destination;
@property (nonatomic, copy) void (^beforeNavigation)(UIViewController *destinationViewController);

- (instancetype)initWithTitle:(NSString *)title requireLogin:(BOOL)isLoginRequired destination:(NSString*)destination beforeNavigation:(void (^)(UIViewController *destinationViewController))beforeNavigation;

@end
