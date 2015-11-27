//
//  Globals.m
//  SwrveTest
//
//  Created by Derek Doherty on 25/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//
//
// This Globals Class uses a Singelton pattern to allow access to vlaues
// Through out the App easily, Here it is just used to store and retrieve
// The entered text in the URL field.

#import "Globals.h"

// We store the string in the NSUserDefaults dictionary using these keys
static NSString* const imageUrlTextKey = @"imageUrlTextKey";

@implementation Globals

//
// Class method to Get a Singelton
//
+(Globals *)sharedInstance
{
    static Globals * sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    // Use this to prevent multiple threads creating different instances
    // and defeating the singelton pattern
    dispatch_once (&onceToken, ^{
        sharedInstance = [[self alloc] init ];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{imageUrlTextKey : @""}];
    });
    return  sharedInstance;
}

//
// Set the imageUrlText and persist it in the NSUserDefaults
//
-(void)setImageUrlText:(NSString *)_imageUrlText
{
    imageUrlText = _imageUrlText;
    [[NSUserDefaults standardUserDefaults]  setObject:_imageUrlText forKey:imageUrlTextKey];
}
+(void)setImageUrlText:(NSString *)imageUrlText
{
    [[Globals sharedInstance] setImageUrlText:imageUrlText];
}


-(NSString *)getImageUrlText
{
    NSString * iut = [[NSUserDefaults standardUserDefaults] objectForKey:imageUrlTextKey];
    imageUrlText = iut;
    return imageUrlText;
}
+(NSString *)getImageUrlText
{
    return [[Globals sharedInstance] getImageUrlText];
}









@end
