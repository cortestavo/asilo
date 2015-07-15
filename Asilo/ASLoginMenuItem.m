//
//  ASLoginMenuItem.m
//  Asilo
//
//  Created by Octavio Cortes on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASLoginMenuItem.h"
#import "LoginViewController.h"
#import "LoginHelper.h"

@implementation ASLoginMenuItem

-(instancetype)initWithTitle:(NSString *)title sourceViewController:(UIViewController *)sourceViewController {
    self = [super initWithTitle:title];
    if(self) {
        self.sourceViewController = sourceViewController;
    }
    return self;
}

-(void)selectItem {
    [LoginHelper displayLoginFromViewController:self.sourceViewController];
}

@end
