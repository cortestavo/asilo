//
//  ASLoginMenuItem.h
//  Asilo
//
//  Created by Octavio Cortes on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASMenuItem.h"
#import <UIKit/UIKit.h>

@interface ASLoginMenuItem : ASMenuItem

@property (nonatomic) UIViewController *sourceViewController;

-(instancetype)initWithTitle:(NSString *)title sourceViewController:(UIViewController *)sourceViewController;

@end
