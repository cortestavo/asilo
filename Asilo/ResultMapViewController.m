//
//  ResultMapViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultMapViewController.h"
#import "ASFilter.h"
#import "SearchNavigationController.h"
#import "ASHomeRepository.h"
#import "ASHome.h"

@interface ResultMapViewController ()

@property (assign, nonatomic) ASFilterType searchType;

@end

@implementation ResultMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchType = ((SearchNavigationController *)self.parentViewController).searchType;
    [self initMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
    Creates a map with Hermosillo as a center
**/
- (void)initMap {
    self.mapView.delegate = self;
    CLLocationDistance distance = 35 * 1609;
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 29.0729670;
    zoomLocation.longitude = -110.9559190;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, distance, distance);
    [self.mapView setRegion:viewRegion animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self getHomes];
}

- (void) getHomes {
    MKMapRect mRect = self.mapView.visibleMapRect;
    CLLocationCoordinate2D ne = MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMaxX(mRect), mRect.origin.y));
    CLLocationCoordinate2D sw = MKCoordinateForMapPoint(MKMapPointMake(mRect.origin.x, MKMapRectGetMaxY(mRect)));
    
    [ASHomeRepository findByAreaWithNorthEast:ne southWest:sw searchType:self.searchType block:^void (NSArray *homes){
        NSLog(@"%@", ((ASHome *)homes[0]).description);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
