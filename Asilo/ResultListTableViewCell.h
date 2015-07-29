//
//  ResultListTableViewCell.h
//  Asilo
//
//  Created by Javier Rosas on 7/15/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHome.h"

@interface ResultListTableViewCell : UITableViewCell

- (void)setupWithHome:(ASHome *)home;
@property (weak, nonatomic) UIViewController *parent;

@end
