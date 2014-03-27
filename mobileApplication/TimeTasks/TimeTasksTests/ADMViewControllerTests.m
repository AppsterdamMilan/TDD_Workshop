//
//  ADMViewControllerTests.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ADMViewController.h"

@interface ADMViewControllerTests : XCTestCase

@end

@implementation ADMViewControllerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatAdmViewControllerIsInStoryboard{

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ADMViewController *unit = [mainStoryboard instantiateViewControllerWithIdentifier:@"ADMViewControllerIdentifier"];
    
    XCTAssertNotNil( unit, @"unit should have been initialized from main storyboard");

}

- (void) testThatAdmViewControllerHasTableView{

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ADMViewController *unit = [mainStoryboard instantiateViewControllerWithIdentifier:@"ADMViewControllerIdentifier"];
    
    [unit performSelector:@selector(loadView) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];

    [unit viewDidLoad];
    
    XCTAssertNotNil( unit.tableView, @"unit should have a tableview when view gets loaded");

}

- (void) test


@end
