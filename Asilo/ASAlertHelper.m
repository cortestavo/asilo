//
//  ASAlertHelper.m
//  Asilo
//
//  Created by Javier Rosas on 7/23/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASAlertHelper.h"
#import <UIKit/UIKit.h>

@implementation ASAlertHelper

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message sourceViewController:(UIViewController *)sourceViewController {
    if ([UIAlertController class]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:cancelAction];
        [sourceViewController presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:sourceViewController cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
@end
