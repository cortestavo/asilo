//
//  WizardLocationViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardLocationViewController.h"
#import "ASHome.h"
#import "ASUser.h"
#import "WizardPicturesController.h"
#import <CoreLocation/CoreLocation.h>

@interface WizardLocationViewController ()

@property (strong, nonatomic) ASHome *home;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) BOOL hasCenteredMapAtLoading;

@end

@implementation WizardLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeHomeObject];
    [self setupNavigationBar];
    [self setupMap];
    [self setupSelectingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeHomeObject {
    if(self.home == nil) {
        self.home = [ASHome getNewObject];
        self.home.owner = [ASUser currentUser];
    }
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Select location";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPublishing:)];
}

- (void)setupMap {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 5;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.mapView.delegate = self;

}

- (void)setupSelectingLocation {
    UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapPressed:)];
    pressRecognizer.minimumPressDuration = 0.3;
    [self.mapView addGestureRecognizer:pressRecognizer];
}

- (void)setDefaultAnnotation:(CLLocationCoordinate2D)coor {
    [self.mapView addAnnotation:[self annotationFromCoordinate:coor]];
}

- (MKPointAnnotation *)annotationFromCoordinate:(CLLocationCoordinate2D)coor {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = @"Your publication will be listed here";
    annotation.coordinate = coor;
    self.home.location = [PFGeoPoint geoPointWithLatitude:coor.latitude longitude:coor.longitude];
    return annotation;
}

#pragma mark - Event handlers

- (void)mapPressed:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    MKPointAnnotation *annotation = [self annotationFromCoordinate:coordinate];
    
    [self.mapView addAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.hasCenteredMapAtLoading) {
        if(self.home.objectId != nil) {
            CLLocationDistance distance = 35 * 1609;
            CLLocationCoordinate2D zoomLocation;
            zoomLocation.latitude = self.home.location.latitude;
            zoomLocation.longitude = self.home.location.longitude;
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, distance, distance);
            [self.mapView setRegion:viewRegion animated:YES];
            [self setDefaultAnnotation:zoomLocation];
        } else {
            const CLLocationDistance METERS_TO_ZOOM = 500;
            mapView.region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, METERS_TO_ZOOM, METERS_TO_ZOOM);
            self.hasCenteredMapAtLoading = true;
            [self setDefaultAnnotation:userLocation.coordinate];
        }
        self.hasCenteredMapAtLoading = true;
    }
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"err: %@", error.description);
}

- (void)cancelPublishing:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)next {
    if ([self populateModel]) {
        [self performSegueWithIdentifier:@"WizardPictures" sender:nil];
    }
}

- (BOOL)populateModel {
    if (self.mapView.annotations.count <= self.mapView.userLocationVisible ? 1 : 0) {
        return NO;
    }
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WizardPictures"]) {
        WizardPicturesController *destination = (WizardPicturesController *)segue.destinationViewController;
        destination.home = self.home;
    }
}

@end
