//
//  HomeTableViewController.h
//  Asilo
//
//  Created by Octavio Cortes on 8/5/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"
#import "ASHome.h"
#import "HomeDetailViewController.h"

@interface HomeTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *homes;
@property (assign) BOOL useMenuItem;

- (instancetype)initWithHomes:(NSArray *)homes;
- (void)setUseMenuItem:(BOOL)useMenuItem;

@end
