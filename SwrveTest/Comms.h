//
//  Comms.h
//  SwrveTest
//
//  Created by Derek Doherty on 27/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Comms : NSObject

-(void)loadImageToImageView:(UIImageView *)iv withUrlString:(NSString *)urlString andSuccessBlock:(void(^)(NSURLRequest *, NSHTTPURLResponse * , UIImage *))succesBlock andFailureBlock:(void(^)(NSURLRequest *, NSHTTPURLResponse * , NSError * ))failureBlock;

@end
