//
//  ASMenuItem.h
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ASMenuItem : NSObject
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL requireLogin;
@property (strong, nonatomic) UIColor *textColor;

-(instancetype)initWithTitle:(NSString *)title;

-(void)selectItem;
- (BOOL) hasLoginPassed;

@end
