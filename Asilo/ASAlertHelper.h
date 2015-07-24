//
//  ASAlertHelper.h
//  Asilo
//
//  Created by Javier Rosas on 7/23/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAlertHelper : NSObject

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message sourceViewController:(UIViewController *)sourceViewController;

@end
