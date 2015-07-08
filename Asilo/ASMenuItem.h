//
//  ASMenuItem.h
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASMenuItem : NSObject
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL isLoginRequired;
@property (strong, nonatomic) NSString *name;

-(instancetype)initWithTitle:(NSString *)title name:(NSString *)name requireLogin:(BOOL)isLoginRequired;
@end
