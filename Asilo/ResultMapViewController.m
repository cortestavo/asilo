//
//  ResultMapViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/7/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ResultMapViewController.h"
#import "HomeTableViewController.h"
#import "ASFilter.h"
#import "SearchNavigationController.h"
#import "ASHomeRepository.h"
#import "ASHome.h"
#import "HomeDetailViewController.h"
#import "ASHomeAnnotation.h"
#import <UIView+Toast.h>
#import "ASLastRegion.h"
#import "ASUser.h"
#import "LoginHelper.h"
#import "ASLastFilter.h"
#import "SaveFilterViewController.h"
#import "RentFilterViewController.h"

@interface ResultMapViewController ()

@property (strong, nonatomic) NSArray *homes;

@end

@implementation ResultMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFilterFromDevice];
    [self initMap];
    NSString* Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
    NSLog(@"output is : %@", Identifier);
}

- (void)viewDidAppear:(BOOL)animated {
    [self getHomes];
}
/**
    Creates a map with Hermosillo as a center
**/
- (void)initMap {
    self.mapView.delegate = self;
    [self.mapView setRegion:[ASLastRegion getRegion] animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [ASLastRegion setRegion:[mapView region]];
    [self getHomes];
}

- (void) getHomes {
    MKMapRect mRect = self.mapView.visibleMapRect;
    CLLocationCoordinate2D ne = MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMaxX(mRect), mRect.origin.y));
    CLLocationCoordinate2D sw = MKCoordinateForMapPoint(MKMapPointMake(mRect.origin.x, MKMapRectGetMaxY(mRect)));
    self.filter.northEast = [PFGeoPoint geoPointWithLatitude:ne.latitude longitude:ne.longitude];
    self.filter.southWest = [PFGeoPoint geoPointWithLatitude:sw.latitude longitude:sw.longitude];
    [self saveFilterToDevice];
    
    [ASHomeRepository findUsingFilterWithBlock:self.filter block:^void (NSArray *homes){
        self.homes = homes;
        if(self.homes.count) {
            [self.mapView removeAnnotations:self.mapView.annotations];
            
            for (int cont = 0, max = (int)[self.homes count]; cont < max; cont++) {
                ASHomeAnnotation *annotation = [[ASHomeAnnotation alloc] initWithHome:self.homes[cont]];
                [self.mapView addAnnotation:annotation];
            }
            [self.mapView makeToast:[NSString stringWithFormat:@"Showing %lu results", (unsigned long)homes.count] duration:3.0 position:CSToastPositionTop];
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[ASHomeAnnotation class]]) {
        ASHomeAnnotation *homeAnnotation = (ASHomeAnnotation *)annotation;
        MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"HomeAnnotation"];
            annotationView = homeAnnotation.annotationView;
        return annotationView;
    } else {
        return nil;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    ASHomeAnnotation *annotation = [view annotation];
    [self performSegueWithIdentifier:@"MapToDetail" sender:annotation.home];
}

#pragma mark - Navigation
- (IBAction)changeToListView:(id)sender {
    UIStoryboard *destinationStoryboard;
    
    destinationStoryboard = [UIStoryboard storyboardWithName:@"Search" bundle:nil];
    UINavigationController *nav = (UINavigationController *)[destinationStoryboard instantiateViewControllerWithIdentifier:@"HomeTable"];
    HomeTableViewController *home = nav.viewControllers[0];
    [home useLeftItemASBackButton];
    home.title = @"List View";
    
    [self presentViewController:nav animated:YES completion:nil];
    [[ASUser currentUser] getFavoritesWithBlock:^(NSMutableArray *homes) {
        home.homes = homes;
        [home.tableView reloadData];
    }];
}

- (IBAction)doFilter:(id)sender {
    switch (self.searchType) {
        case ASFilterTypeForRent:
            [self performSegueWithIdentifier:@"RentFilter" sender:nil];
            break;
            
        case ASFilterTypeForSale:
            [self performSegueWithIdentifier:@"SaleFilter" sender:nil];
            break;
    }
}

- (IBAction)saveSearch:(id)sender {
    if([ASUser currentUser] != nil) {
        [self performSegueWithIdentifier:@"SaveFilter" sender:nil];
    } else {
        [LoginHelper displayLoginFromViewController:self block:^{
            [self performSegueWithIdentifier:@"SaveFilter" sender:nil];
        }];
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"RentFilter"]) {
        RentFilterViewController *destination = (RentFilterViewController *)segue.destinationViewController;
        self.filter.type = ASFilterTypeForRent;
        [self saveFilterToDevice];
        destination.parent = self;
    }
    if([segue.identifier isEqualToString:@"SaleFilter"]) {
        RentFilterViewController *destination = (RentFilterViewController *)segue.destinationViewController;
        self.filter.type = ASFilterTypeForSale;
        [self saveFilterToDevice];
        destination.parent = self;
    }
    if([segue.identifier isEqualToString:@"SaveFilter"]) {
        SaveFilterViewController *destination = (SaveFilterViewController *)segue.destinationViewController;
        destination.filter = self.filter;
    }
    if ([segue.identifier isEqualToString:@"MapToDetail"]) {
        ASHome *home = (ASHome *)sender;
        HomeDetailViewController *destination = (HomeDetailViewController *)segue.destinationViewController;
        destination.home = home;
    }
}

- (IBAction)returnToSaveFilter:(UIStoryboardSegue *)segue {
    NSLog(@"And now we are back.");
}

- (void)loadFilterFromDevice {
    if(self.searchType == ASFilterTypeForRent) {
        self.filter = [ASLastFilter getRentFilter];
    } else {
        self.filter = [ASLastFilter getSaleFilter];
    }
}

- (void)saveFilterToDevice {
    if(self.searchType == ASFilterTypeForRent) {
        [ASLastFilter setRentFilter:self.filter];
    } else {
        [ASLastFilter setSaveFilter:self.filter];
    }
}

@end
