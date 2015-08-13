//
//  ASLastFilter.h
//  Asilo
//
//  Created by Octavio Cortes on 8/12/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASFilter.h"

@interface ASLastFilter : NSObject

+ (void) setRentFilter:(ASFilter *)filter;
+ (void) setSaveFilter:(ASFilter *)filter;
+ (ASFilter *) getRentFilter;
+ (ASFilter *) getSaleFilter;

@end
