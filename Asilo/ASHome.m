//
//  Home.m
//  Asilo
//
//  Created by Octavio Cortes on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASHome.h"
#import <Parse/PFObject+Subclass.h>
#import <Foundation/Foundation.h>

@implementation ASHome

@dynamic address;           // shared
@dynamic baths;             // shared
@dynamic beds;              // shared
@dynamic deposit;           // rent
@dynamic homeDescription;   // shared
@dynamic hasAC;             // shared
@dynamic hasHeating;        // shared
@dynamic isForSale;         // NA
@dynamic isForRent;         // NA
@dynamic isFurnished;       // rent
@dynamic lease;             // rent
@dynamic location;          // NA
@dynamic owner;             // NA
@dynamic parkingLots;       // shared
@dynamic petsAllowed;       // rent
@dynamic priceForRent;      // rent
@dynamic priceForSale;      // sale
@dynamic squareMeters;      // shared
@dynamic tags;              // shared
@dynamic photos;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Home";
}

+ (instancetype)objectWithClassName:(NSString *)className {
    return [super objectWithClassName:className];
}

+ (instancetype)getNewObject {
    return [super objectWithClassName:@"Home"];
}

- (void) addPhoto:(UIImage *)photo {
    NSData *imageData = UIImageJPEGRepresentation(photo, 80);
    PFFile *imageFile = [PFFile fileWithData:imageData];
    if(self.photos == nil) {
        self.photos = [NSMutableArray array];
    }
    [self.photos addObject:imageFile];
}

- (int) countOfPhotos {
    return self.photos == nil ? 0 : (int)[self.photos count];
}

- (void) getPhotoAtIndex:(int)index block:(void (^)(UIImage *))block {
    if(self.photos == nil || index < 0 || index > [self.photos count]) {
        return;
    }
    PFFile *image = [self.photos objectAtIndex:index];
    [image getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if(error == nil) {
            block([UIImage imageWithData:imageData]);
        }
    }];
}

@end
