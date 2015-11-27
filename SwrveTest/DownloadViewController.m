//
//  DownloadViewController.m
//  SwrveTest
//
//  Created by Derek Doherty on 24/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

//
// This class handles the viewcontroller for the first view , the URL text is entered here
// and button animation, on pressing the download button the requested URL image is displayed
// via a Segue to the ImageVIewController

#import "DownloadViewController.h"
#import "ImageViewController.h"
#import "Globals.h"


@interface DownloadViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *imageUrlField;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
//
// Using a shape layer to construct the stroke animation around the download button
//
@property (strong, nonatomic) CAShapeLayer *circle;

@end

@implementation DownloadViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageUrlField.delegate = self;
    
    //
    // Put some decoration on the textField
    //
    self.imageUrlField.layer.cornerRadius = 5.0;
    self.imageUrlField.layer.borderWidth = 2.0;
    self.imageUrlField.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.imageUrlField.layer.shadowOpacity = 0.75;
    self.imageUrlField.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    self.imageUrlField.layer.shadowRadius = 3.0;
    

    //
    // Set the NavBar Color
    //
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
    
    self.navigationItem.title = @"Image URL";
    
    //
    // Preload the textField with a demo image URL
    //
    [Globals setImageUrlText:@"http://img.youtube.com/vi/co6WMzDOh1o/mqdefault.jpg"];
    
    //
    // Fill out the URL textField with the persisted String
    //
    self.imageUrlField.text = [Globals getImageUrlText];
    //
    // Add the Shape Layer to the Button view
    //
    [self addLayerToButtonView];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self registerForNotifications];
    [self buttonAnimation];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.circle removeAnimationForKey:@"draw"];
    [Globals setImageUrlText:self.imageUrlField.text];
    
}

//
// Just moving to the ImageViewController
//
- (IBAction)downloadButtonPressed:(UIButton *)sender
{
    [self.imageUrlField endEditing:YES];
    
    [self performSegueWithIdentifier:@"showImage" sender:nil];
}



#pragma mark - Animation
//
// Create a circle Shape Layer and add it to the Button View
//
-(void)addLayerToButtonView
{
    int radius = 50;
    self.circle = [CAShapeLayer layer];
    
    // Make a circular shape
    self.circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in the Button View
    self.circle.position = CGPointMake(CGRectGetMidX(self.buttonView.bounds)-radius,
                                  CGRectGetMidY(self.buttonView.bounds)-radius);
    
    // Configure the apperence of the circle
    self.circle.fillColor = [UIColor clearColor].CGColor;
    self.circle.strokeColor = [UIColor redColor].CGColor;
    //self.circle.lineDashPattern = @[@2, @3];
    self.circle.lineWidth = 3;
    
    // Add to buttonView layer
    [self.buttonView.layer addSublayer:self.circle];
    
}


//
// Build and add an animation around the Download Button
//
-(void)buttonAnimation
{
    //
    // Using an Animation group here to achieve the stroke animation
    //
    CABasicAnimation * strokStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokStartAnimation.fromValue = @-0.5;
    strokStartAnimation.toValue = @1.0;
    
    CABasicAnimation * strokEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokEndAnimation.fromValue = @0.0;
    strokEndAnimation.toValue = @1.0;
    
    CAAnimationGroup * strokeAnimationGroup = [[CAAnimationGroup alloc] init];
    strokeAnimationGroup.duration = 2.5;
    //strokeAnimationGroup.repeatDuration = 5.0;
    strokeAnimationGroup.repeatCount = 10000000.0;
    
    //
    // Add the two animations to the group
    //
    strokeAnimationGroup.animations = @[strokStartAnimation, strokEndAnimation];
    
    strokeAnimationGroup.removedOnCompletion = NO;
    strokeAnimationGroup.fillMode = kCAFillModeForwards;
    strokeAnimationGroup.delegate = self;
    
    // Add the animation to the circle layer
    [self.circle addAnimation:strokeAnimationGroup forKey:@"draw"];
    
}
-(void)animationDidStart:(CAAnimation *)anim
{
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}



#pragma mark - Keyboard Notification Handling

- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

//
// Called when the UIKeyboardDidShowNotification is sent.
//
- (void)keyboardWillShow:(NSNotification*)aNotification
{
    //NSLog(@"Keyboard will be shown");
    [self adjustKeyboardForShow:YES forNotification:aNotification];
}
//
// Called when the UIKeyboardWillHideNotification is sent
//
- (void)keyboardWillHide:(NSNotification*)aNotification
{
    //NSLog(@"Keyboard will be Hidden");
    [self adjustKeyboardForShow:NO forNotification:aNotification];
}

//
// Helper Method for Keyboard Notifications, Scrollview adjustments
//
-(void)adjustKeyboardForShow:(BOOL)show forNotification:(NSNotification *)notif
{
//    NSDictionary * userDict = notif.userInfo;
//    CGSize sizeOfKB = [userDict[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    CGFloat adjustHeight = (sizeOfKB.height + 80) * (show ? 1: -1);
//    [self.scrollView setContentInset:UIEdgeInsetsMake(0, 0, adjustHeight, 0)];
//    [self.scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, 0, adjustHeight, 0)];
    //[self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1,self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.imageUrlField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.imageUrlField resignFirstResponder];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.imageUrlField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

//
// Just passing the entered text to the ImageViewController
// Persist the entered text too
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageViewController * ivc = (ImageViewController *)[segue destinationViewController];
    
    ivc.imageUrlString = self.imageUrlField.text;
    [Globals setImageUrlText:self.imageUrlField.text];
}


@end
