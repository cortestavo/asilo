//
//  SearchNavigationController.h
//  Asilo
//
//  Created by Javier Rosas on 7/8/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchNavigationController : UINavigationController

typedef enum {
    ASSearchTypeForRent,
    ASSearchTypeForSale
} ASSearchType;

@property (assign, nonatomic) ASSearchType searchType;

@end
