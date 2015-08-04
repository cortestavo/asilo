//
//  HomeDetailViewController.m
//  Asilo
//
//  Created by Javier Rosas on 7/16/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "MHGallery.h"
#import "MHPresenterImageView.h"
#import "UIImageView+WebCache.h"

@interface HomeDetailViewController ()
@property (weak, nonatomic) IBOutlet MHPresenterImageView *headerImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedsAndBathsLabel;
@property (weak, nonatomic) IBOutlet UILabel *squareMetersLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicationTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *hasAcLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasHeatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingLotsLabel;
@property (weak, nonatomic) IBOutlet UIView *rentInfoView;
@property (weak, nonatomic) IBOutlet UILabel *isFurnishedLabel;
@property (weak, nonatomic) IBOutlet UILabel *petsAllowedLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *depositLabel;

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Uncomment to include a test home ==================
//    ASHome *testHome = [ASHome object];
//    testHome.priceForRent = @5000;
//    testHome.isForRent = YES;
//    testHome.beds = @2;
//    testHome.baths = @1;
//    testHome.squareMeters = @210;
//    testHome.address = @"Blv. Fco. Eusebio Kino No. 123, Col. Pitic, Hermosillo, Sonora.";
//    self.home = testHome;
    // =========================================
    if(self.ableToEdit == true) {
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(goToEdit)];
        self.navigationItem.rightBarButtonItem = menuButton;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [self populateView];
}

- (void) goToEdit {
    UIStoryboard *searchStoryboard = [UIStoryboard storyboardWithName:@"Publications" bundle:nil];
    UINavigationController *nvc = (UINavigationController *)[searchStoryboard instantiateViewControllerWithIdentifier:@"NavigationWizardLocation"];
    HomeDetailViewController *vc = (HomeDetailViewController *)nvc.viewControllers[0];
    vc.home = self.home;
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)populateView {
    if (!self.home) {
        @throw [NSException exceptionWithName:@"Home not referenced" reason:@"A reference to a home was not passed. No info to show" userInfo:nil];
    }
    NSNumberFormatter *decimalFormatter = [NSNumberFormatter new];
    decimalFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    decimalFormatter.maximumFractionDigits = 2;
    self.addressLabel.text = self.home.address;
    self.bedsAndBathsLabel.text = [NSString stringWithFormat:@"%d bedrooms, %d bathrooms", self.home.beds.intValue, self.home.baths.intValue];
    NSString *formattedArea = [decimalFormatter stringFromNumber:self.home.squareMeters];
    self.squareMetersLabel.text = [NSString stringWithFormat:@"%@ m²", formattedArea];
    self.publicationTypeLabel.text = self.home.isForRent ? @"FOR RENT" : @"FOR SALE";
    NSString *formattedPrice = [decimalFormatter stringFromNumber:self.home.isForRent ? self.home.priceForRent : self.home.priceForSale];
    if (self.home.isForRent) {
        self.priceLabel.text = [NSString stringWithFormat:@"$%@/mo", formattedPrice];
        self.isFurnishedLabel.text = [NSString stringWithFormat:@"Furnished: %@", self.home.isFurnished ? @"Yes" : @"No"];
        self.petsAllowedLabel.text = [NSString stringWithFormat:@"Pets allowed: %@", self.home.petsAllowed ? @"Yes" : @"No"];
        self.leaseLabel.text = [NSString stringWithFormat:@"Lease: %d months", self.home.lease.intValue];
        NSString *formattedDeposit = [decimalFormatter stringFromNumber:self.home.deposit];
        self.depositLabel.text = [NSString stringWithFormat:@"Deposit: $%@", formattedDeposit];
    } else {
        self.priceLabel.text = [NSString stringWithFormat:@"$%@", formattedPrice];
        self.rentInfoView.hidden = YES;
    }
    self.descriptionText.text = self.home.homeDescription;
    self.descriptionText.layer.borderColor = [UIColor colorWithRed:230.0/255.0
                                                             green:230.0/255.0
                                                              blue:230.0/255.0
                                                             alpha:1.0].CGColor;
    self.descriptionText.layer.borderWidth = 1;
    self.descriptionText.layer.cornerRadius = 5;
    self.hasAcLabel.text = [NSString stringWithFormat:@"A.C.: %@", self.home.hasAC ? @"Yes" : @"No"];
    self.hasHeatingLabel.text = [NSString stringWithFormat:@"Heating: %@", self.home.hasHeating ? @"Yes" : @"No"];
    self.parkingLotsLabel.text = [NSString stringWithFormat:@"Parking lots: %d", self.home.parkingLots.intValue];

    int sizeOfPhotos= [self.home countOfPhotos];
    NSMutableArray *galleryItems2 = [[NSMutableArray alloc] initWithCapacity:sizeOfPhotos];
    int cont = 0;
    for(PFFile *file in self.home.photos) {
        MHGalleryItem *im = [[MHGalleryItem alloc]initWithURL:[file url] galleryType:MHGalleryTypeImage];
        [galleryItems2 insertObject:im atIndex:cont];
        cont++;
    }
    NSArray *galleryItems3 = [NSArray arrayWithArray:galleryItems2];
    
    __weak HomeDetailViewController *blockSelf = self;
    
    [self.headerImageView setInseractiveGalleryPresentionWithItems:galleryItems3 currentImageIndex:0 currentViewController:self finishCallback:^(NSInteger currentIndex,UIImage *image,MHTransitionDismissMHGallery *interactiveTransition,MHGalleryViewMode viewMode) {
        if (viewMode == MHGalleryViewModeOverView) {
            [blockSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            blockSelf.headerImageView.image = image;
            blockSelf.headerImageView.currentImageIndex = currentIndex;
            [blockSelf.presentedViewController dismissViewControllerAnimated:YES dismissImageView:blockSelf.headerImageView completion:nil];
        }
    }];
    
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:((MHGalleryItem *)galleryItems3[0]).URLString]];
    [self.headerImageView setUserInteractionEnabled:YES];
    
    self.headerImageView.shoudlUsePanGestureReconizer = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
