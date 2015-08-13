//
//  ResultMapViewController.h
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASBaseViewController.h"
#import "ASFilter.h"
#import <MapKit/MapKit.h>

@interface ResultMapViewController : ASBaseViewController<MKMapViewDelegate>

@property (assign, nonatomic) ASFilterType searchType;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) ASFilter *filter;

-(void) saveFilterToDevice;
-(void) loadFilterFromDevice;

@end
