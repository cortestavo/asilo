//
//  ASHomeAnnotation.h
//  Asilo
//
//  Created by Javier Rosas on 7/22/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ASHome.h"

@interface ASHomeAnnotation : NSObject<MKAnnotation>

@property (copy, nonatomic) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic, readonly)ASHome *home;

-(instancetype)initWithHome:(ASHome *)home;
- (MKAnnotationView *)annotationView;

@end
