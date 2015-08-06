//
//  FavoritesTableViewController.h
//  Asilo
//
//  Created by Octavio Cortes on 8/5/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASBaseViewController.h"

@interface FavoritesTableViewController : ASBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *homes;

@end
