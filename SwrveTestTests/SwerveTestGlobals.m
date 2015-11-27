//
//  SwerveTestGlobals.m
//  SwrveTest
//
//  Created by Derek Doherty on 27/11/2015.
//  Copyright © 2015 Derek Doherty. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Globals.h"

@interface SwerveTestGlobals : XCTestCase

@end

@implementation SwerveTestGlobals

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//
// Test the sharedInstance method returns a valid instance
//
- (void)testSingeltonCreation
{
    Globals * sg = [Globals sharedInstance];
    
    XCTAssert((sg != nil) , @"Singelton not initialised correctly");
}

//
// Test the shared instance method returns the same instance each time
//
- (void)testSingeltonValidity
{
    Globals * sg1 = [Globals sharedInstance];
    Globals * sg2 = [Globals sharedInstance];
    
    XCTAssertEqual(sg1, sg2 , @"Multiple instances created incorrectly");
}

//
// Test the saving and retrival of a String to the Global/NSUserDefaults store
//
- (void)testSavingToGlobal
{
    NSString * urlStringToStore = @"http://www.example.com";
    
    [Globals setImageUrlText:urlStringToStore];
    
    NSString * retrievedString = [Globals getImageUrlText];
    
    XCTAssertEqual(urlStringToStore, retrievedString , @"Value not stored correctly in global store");
}

//- (void)testPerformanceExample
//{
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
