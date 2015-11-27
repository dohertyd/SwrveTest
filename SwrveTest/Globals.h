//
//  Globals.h
//  SwrveTest
//
//  Created by Derek Doherty on 25/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject
{
    NSString * imageUrlText;
}

+(Globals *)sharedInstance;

+(NSString *)getImageUrlText;
+(void)setImageUrlText:(NSString *)imageUrlText;

@end
