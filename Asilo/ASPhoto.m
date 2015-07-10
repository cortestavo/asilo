//
//  Photo.m
//  Asilo
//
//  Created by Octavio Cortes on 7/9/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASPhoto.h"
#import <Parse/PFObject+Subclass.h>

@implementation ASPhoto

@dynamic home;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"ASPhoto";
}

- (void)setPhoto:(UIImage *)photo {
    NSData *photoData = UIImagePNGRepresentation(photo);
    PFFile *photoFile = [PFFile fileWithData:photoData];
    self[@"file"] = photoFile;
}

- (PFFile *)getPhoto {
    return (PFFile *)self[@"file"];
}

@end
