//
//  ResultMapViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultMapViewController.h"
#import "ResultListTableViewController.h"
#import "ASFilter.h"
#import "SearchNavigationController.h"
#import "ASHomeRepository.h"
#import "ASHome.h"

@interface ResultMapViewController ()

@property (nonatomic) ASFilterType searchType;
@property (strong, nonatomic) NSArray *homes;

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

- (IBAction)listAction:(id)sender {
    [self changeToListView];
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
        self.homes = homes;
    }];
}

#pragma mark - Navigation

-(void)changeToListView {
    [self performSegueWithIdentifier:@"ResultList" sender:nil];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ResultList"]) {
        ResultListTableViewController *listView = (ResultListTableViewController *)segue.destinationViewController;
        listView.homes = self.homes;
    }
}

@end
