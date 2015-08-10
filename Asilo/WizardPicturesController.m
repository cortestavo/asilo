//
//  WizardPicturesController.m
//  Asilo
//
//  Created by Javier Rosas on 7/21/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "WizardPicturesController.h"
#import "WizardSharedDataViewController.h"
#import "PictureCollectionViewCell.h"
#import "ASAlertHelper.h"

@interface WizardPicturesController ()

@end

@implementation WizardPicturesController

static NSString * const reuseIdentifier = @"WizardPictureCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    self.collectionView.allowsMultipleSelection = YES;
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Add pictures";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    self.navigationController.toolbarHidden = NO;
}

- (void)next {
    if (self.home.countOfPhotos > 0) {
        [self performSegueWithIdentifier:@"WizardShared" sender:nil];
    } else {
        [ASAlertHelper alertWithTitle:@"Add a picture" message:@"Please add at least one picture" sourceViewController:self];
    }
}

#pragma mark - Actions

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

# pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.home addPhoto:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WizardShared"]) {
        WizardSharedDataViewController *destination = (WizardSharedDataViewController *)segue.destinationViewController;
        destination.home = self.home;
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.home countOfPhotos];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PictureCollectionViewCell *cell = (PictureCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self.home getPhotoAtIndex:(int)indexPath.row block:^(UIImage *image) {
        cell.imageView.image = image;
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-background.jpg"]];
    }];
    return cell;
}

- (IBAction)trashedImages:(id)sender {
    NSArray *selected = [self.collectionView indexPathsForSelectedItems];
    for(NSIndexPath *indexPath in selected) {
        [self.home.photos removeObjectAtIndex:indexPath.row];
    }
    [self.collectionView deleteItemsAtIndexPaths:selected];
    [self.collectionView reloadData];
}

@end
