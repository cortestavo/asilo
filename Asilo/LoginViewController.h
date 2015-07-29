//
//  LoginViewController.h
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASBaseViewController.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginFacebookButton;
@property (weak, nonatomic) IBOutlet UILabel *loggingOutLabel;
@property (nonatomic, copy) void (^block)(void);

- (IBAction)loginWithFacebook:(id)sender;
- (void) setBlock:(void (^)(void))block;

@end
