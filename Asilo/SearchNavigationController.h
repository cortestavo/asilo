//
//  SearchNavigationController.h
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASFilter.h"

@interface SearchNavigationController : UINavigationController

@property (assign, nonatomic) ASFilterType searchType;

@end
