//
//  WizardLocationViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/10/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardLocationViewController.h"
#import "ASHome.h"
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
    [self setupNavigationBar];
    [self setupMap];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.hasCenteredMapAtLoading) {
        mapView.region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100);
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
    [self performSegueWithIdentifier:@"WizardShared" sender:nil];
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
