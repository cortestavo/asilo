//
//  Photo.h
//  Asilo
//
//  Created by Octavio Cortes on 7/9/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Parse/Parse.h>
@class ASHome;

@interface ASPhoto : PFObject <PFSubclassing>

@property (nonatomic) ASHome *home;

+ (NSString *)parseClassName;
- (void)setPhoto:(UIImage *)photo;
- (PFFile *)getPhoto;

@end
