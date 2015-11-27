//
//  ImageViewController.h
//  SwrveTest
//
//  Created by Derek Doherty on 25/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

//
// Gives an easy macro using hexvalues in UIColor generation
//
#define UICOLORFROMRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//
// This is the Url entered by the user and passed from theDownloadViewController
//
@property (strong, nonatomic) NSString * imageUrlString;


@end
