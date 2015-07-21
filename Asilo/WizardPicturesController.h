//
//  WizardPicturesController.h
//  Asilo
//
//  Created by Javier Rosas on 7/21/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHome.h"

@interface WizardPicturesController : UICollectionViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property ASHome *home;

@end
