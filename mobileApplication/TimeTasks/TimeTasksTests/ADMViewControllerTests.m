//
//  ADMViewControllerTests.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ADMViewController.h"

//utility
#import "XCTestCase+ADMTestingExtensions.h"

//participants
#import "ADMTimeTasksConnector.h"
#import "ADMTimeTask.h"

@implementation ADMTimeTasksConnector (TestingExtensions)

- (void) fake_downloadTimeTasksListWithCompletionHandler:(void (^)(NSArray *))completionHandler failureHandler:(void (^)(NSError *))failureHandler{

    [XCTestCase addBoolPayloadToObject:self boolValue:YES];

//    NSArray *mockModel = @[
//                           @{
//                               @"id":@"133421",
//                               @"description":@"Buy chocolate",
//                               @"time":@30,
//                               @"priority":@2,
//                               @"due":@1395068086,
//                               @"completed":@NO,
//                               @"lastUpdate":@1395064566
//                               },
//                           @{
//                               @"id":@"133422",
//                               @"description":@"Buy milk",
//                               @"time":@20,
//                               @"priority":@1,
//                               @"due":@1395068086,
//                               @"completed":@NO,
//                               @"lastUpdate":@1395064566
//                               }
//                           
//
//                        ];
//    
//    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:2];
//    for (NSDictionary *rawTask in mockModel) {
//        
//        ADMTimeTask *newTask = [[ADMTimeTask alloc] initWithDictionary: rawTask];
//        
//        [tmp addObject: newTask];
//        
//        
//    }
//    if(completionHandler)
//        completionHandler([NSArray arrayWithArray:tmp]);
    
    
}

@end

@interface ADMViewControllerTests : XCTestCase{

    ADMViewController *unit;

}

@end

@implementation ADMViewControllerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    unit = [mainStoryboard instantiateViewControllerWithIdentifier:@"ADMViewControllerIdentifier"];
    
    [unit performSelector:@selector(loadView) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];

}

- (void)tearDown
{
    unit=nil;
    [super tearDown];
}

- (void) testThatAdmViewControllerIsInStoryboard{

    XCTAssertNotNil( unit, @"unit should have been initialized from main storyboard");

}

- (void) testThatAdmViewControllerHasTableView{

   
    [unit viewDidLoad];
    
    XCTAssertNotNil( unit.tableView, @"unit should have a tableview when view gets loaded");

}

//- (void) testThatAdmViewControllerBeginsDownloadOfNewTaskListOnAppear{
//
//    [XCTestCase swapInstanceMethodsForClass:[ADMTimeTasksConnector class] selector:@selector(downloadTimeTasksListWithCompletionHandler:failureHandler:) andSelector:@selector(fake_downloadTimeTasksListWithCompletionHandler:failureHandler:)];
//    
//    [unit viewDidLoad];
//    
//    [unit viewDidAppear:NO];
//    
//    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
//    
//    BOOL hasBeenCalled = [XCTestCase getBoolPayloadFromObject: sharedConnector];
//    
//    XCTAssertTrue( hasBeenCalled, @"unit should have begun download task on connector");
//
//    [XCTestCase swapInstanceMethodsForClass:[ADMTimeTasksConnector class] selector:@selector(downloadTimeTasksListWithCompletionHandler:failureHandler:) andSelector:@selector(fake_downloadTimeTasksListWithCompletionHandler:failureHandler:)];
//
//}


- (void) testThatAdmViewControllerBeginsDownloadOfNewTaskListOnAppear{
    
    
    [unit viewDidLoad];
    
    [unit viewDidAppear:NO];
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    
    BOOL hasBeenCalled = [XCTestCase getBoolPayloadFromObject: sharedConnector];
    
    XCTAssertTrue( hasBeenCalled, @"unit should have begun download task on connector");
    
    
}

@end
