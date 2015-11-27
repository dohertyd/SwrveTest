//
//  SwrveTestComm.m
//  SwrveTest
//
//  Created by Derek Doherty on 27/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "Comms.h"

@interface SwrveTestComm : XCTestCase
@property (strong, nonatomic) XCTestExpectation *expectation;

@end

@implementation SwrveTestComm

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//
// Using the expectation Semaphore pattern for testing asynchronous Network call to get Image
//
- (void)testImageLoading
{
    self.expectation = [self expectationWithDescription:@"Expect Image loading to be completed sucessfully"];
    

    Comms *ci = [[Comms alloc] init];
    
    UIImageView * iv = [[UIImageView alloc] init];
    NSString * imageUrlString = @"http://img.youtube.com/vi/co6WMzDOh1o/mqdefault.jpg";
    
    [ci loadImageToImageView:iv withUrlString:imageUrlString andSuccessBlock:^(NSURLRequest * request, NSHTTPURLResponse * response, UIImage * image)
     {
         [self.expectation fulfill];
     }
     andFailureBlock:^(NSURLRequest * request, NSHTTPURLResponse * response, NSError * error)
     {
         XCTAssert(nil);  // Fail the Testcase
     }];
    
    // Wait for the Semaphore to be released
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error)
     {
         if (error)
         {
             NSLog(@"Timeout Error while loading image: %@", error);
         }
     }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
