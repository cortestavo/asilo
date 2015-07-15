//
//  LoginViewController.h
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASBaseViewController.h"

@interface LoginViewController : ASBaseViewController

@property (weak, nonatomic) IBOutlet UIButton *loginFacebookButton;
@property (weak, nonatomic) IBOutlet UILabel *loggingOutLabel;

- (IBAction)loginWithFacebook:(id)sender;

@end
