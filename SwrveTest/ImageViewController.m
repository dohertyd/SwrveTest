//
//  ImageViewController.m
//  SwrveTest
//
//  Created by Derek Doherty on 25/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import "ImageViewController.h"
#import "Comms.h"

@interface ImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *downloadImageView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation ImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:UICOLORFROMRGB(0x1A1A1A)];
    
    //
    //  Setting up text for Nav bar title on iphone and Ipad
    //
    if ( [ UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [self.navigationController.navigationBar setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont fontWithName:@"Avenir" size:18],
          NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    }
    else
    {
        [self.navigationController.navigationBar setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:
          [UIFont fontWithName:@"Avenir" size:17],
          NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    }
    
    //
    // Initialize the ImageView with a placholder image
    //
    self.downloadImageView.image = [UIImage imageNamed:@"ThumbnailPlaceholder.png"];
    
    //
    // Setup activity indicator as a right bar button
    // Show spinner until image loading is finished
    //
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    
    [[self navigationItem] setRightBarButtonItem:barButton];
    [self.activityIndicator startAnimating];
    self.navigationItem.title = @"Loading ...";
    
    [self loadImage];
}

//
// Using the outFactored Comms class to fill out the ImageView
//
-(void)loadImage
{
    __weak ImageViewController * weakSelf = self;
    Comms *ci = [[Comms alloc] init];
    
    [ci loadImageToImageView:self.downloadImageView withUrlString:self.imageUrlString andSuccessBlock:^(NSURLRequest * request, NSHTTPURLResponse * response, UIImage * image)
     {
         [weakSelf.activityIndicator stopAnimating];
         weakSelf.navigationItem.title = @"Image:";
         
         weakSelf.downloadImageView.image = image;
         [weakSelf.downloadImageView setNeedsLayout];
     }
     andFailureBlock:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error)
     {
         [weakSelf.activityIndicator stopAnimating];
         weakSelf.navigationItem.title = @"Image:";
         
         //
         // Use an alert dialog here to indicate a problem with loading the image
         //
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"There was an error loading the image"
                                                    message:[NSString stringWithFormat:@"%@",[error localizedDescription]]
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alertView show];
         
     }];
    
}


@end
