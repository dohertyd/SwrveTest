//
//  Comms.m
//  SwrveTest
//
//  Created by Derek Doherty on 27/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import "Comms.h"
#import "UIImageView+AFNetworking.h"

@implementation Comms

-(void)loadImageToImageView:(UIImageView *)downloadImageView withUrlString:(NSString *)imageUrlString andSuccessBlock:(void(^)(NSURLRequest *, NSHTTPURLResponse * , UIImage *))succesBlock andFailureBlock:(void(^)(NSURLRequest *, NSHTTPURLResponse * , NSError * ))failureBlock
{
    //
    // This AFNetworking Category caches to disk, going to ignore local cache in this case
    // So full re load each time
    //
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrlString]
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:20];
    
    
    [downloadImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    //
    // Using the AFnetworking Category UIImageView+AFNetworking
    //
    //__weak ImageViewController * weakSelf = self;
    [downloadImageView setImageWithURLRequest:urlRequest
                                  placeholderImage:[UIImage imageNamed:@"ThumbnailPlaceholder.png"]
     success:succesBlock
     failure:failureBlock];
}

@end
