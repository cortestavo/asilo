//
//  ASHomeAnnotation.m
//  Asilo
//
//  Created by Javier Rosas on 7/22/15.
//  Copyright (c) 2015 Nearsoft. All rights reserved.
//

#import "ASHomeAnnotation.h"
#import "ASHome.h"

@interface ASHomeAnnotation()

@end

@implementation ASHomeAnnotation

-(instancetype)initWithHome:(ASHome *)home {
    self = [super init];
    if (self) {
        _title = @"Tap to view details";
        _coordinate = CLLocationCoordinate2DMake(home.location.latitude, home.location.longitude);
        _home = home;
    }
    return self;
}

- (MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"HomeAnnotation"];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    lbl.backgroundColor = [UIColor redColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.alpha = 0.8;
    lbl.tag = 42;
    lbl.layer.masksToBounds = YES;
    lbl.layer.cornerRadius = 12;
    lbl.textAlignment = NSTextAlignmentCenter;
    if (self.home.isForRent) {
        lbl.text = [self abbreviateNumber:self.home.priceForRent.intValue];
    } else {
        lbl.text = [self abbreviateNumber:self.home.priceForSale.intValue];
    }

    [annotationView addSubview:lbl];
    annotationView.frame = lbl.frame;
    return annotationView;
}

-(NSString *)abbreviateNumber:(int)num {
    
    NSString *abbrevNum;
    float number = (float)num;
    
    //Prevent numbers smaller than 1000 to return NULL
    if (num >= 1000) {
        NSArray *abbrev = @[@"K", @"M", @"B"];
        
        for (long i = abbrev.count - 1; i >= 0; i--) {
            
            // Convert array index to "1000", "1000000", etc
            int size = pow(10,(i+1)*3);
            
            if(size <= number) {
                // Removed the round and dec to make sure small numbers are included like: 1.1K instead of 1K
                number = number/size;
                NSString *numberString = [self floatToString:number];
                
                // Add the letter for the abbreviation
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];
            }
            
        }
    } else {
        
        // Numbers like: 999 returns 999 instead of NULL
        abbrevNum = [NSString stringWithFormat:@"%d", (int)number];
    }
    
    return abbrevNum;
}

- (NSString *) floatToString:(float) val {
    NSString *ret = [NSString stringWithFormat:@"%.1f", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    
    while (c == 48) { // 0
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
        
        //After finding the "." we know that everything left is the decimal number, so get a substring excluding the "."
        if(c == 46) { // .
            ret = [ret substringToIndex:[ret length] - 1];
        }
    }
    
    return ret;
}

@end
