//
//  ADMViewControllerTests.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

#import "ADMViewController.h"

//utility
#import "XCTestCase+ADMTestingExtensions.h"
#import <OCMock/OCMock.h>

//participants
#import "ADMTimeTasksConnector.h"
#import "ADMTimeTask.h"
#import "ADMTableViewHandler.h"

@implementation ADMTimeTasksConnector (TestingExtensions)

- (void) fake_downloadTimeTasksListWithCompletionHandler:(void (^)(NSArray *))completionHandler failureHandler:(void (^)(NSError *))failureHandler{

    [XCTestCase addBoolPayloadToObject:self boolValue:YES];

    
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

- (void) testThatAdmViewControllerHasName{

    [unit viewDidLoad];

    XCTAssertTrue([unit.title isEqualToString:@"TimeTasks!"], @"unit should be called TimeTasks!");

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

- (void) testThatAdmViewControllerInitializesTableViewHandler{
    
    [unit viewDidLoad];
    
    ADMTableViewHandler *handler = [unit valueForKey:@"_handler"];
    
    XCTAssertNotNil( handler, @"unit's tableviewhandler should have been initialized");
    
}

- (void) testThatAdmViewControllerHooksTableViewDelegateAndDatasourceToHandler{
    
    [unit viewDidLoad];
    
    ADMTableViewHandler *handler = [unit valueForKey:@"_handler"];
    
    UITableView *tableView = [unit tableView];
    
    XCTAssertTrue( (tableView.delegate == handler)&&(tableView.dataSource == handler) , @"unit should have linked handler with tableview delegate and datasource");
    
}



- (void) testThatAdmViewControllerBeginsDownloadOfNewTaskListOnAppear{
    
    
    [unit viewDidLoad];
    
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    id mock = [OCMockObject partialMockForObject: sharedConnector];
    [[mock expect] downloadTimeTasksListWithCompletionHandler:OCMOCK_ANY failureHandler:OCMOCK_ANY];
    
    [unit viewDidAppear:NO];

    [mock verify];
    
    
}

- (void) testThatAdmViewControllerSetsHandlerTableDataWhenDownloadIsCompleted{


    [unit viewDidLoad];
    
    ADMTableViewHandler *handler = [unit valueForKey:@"_handler"];
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    id mockConnector = [OCMockObject partialMockForObject: sharedConnector];
   
    
    __block NSArray *expectedArray = @[@"asd",@"lol"];
    
    [[[mockConnector expect] andDo:^(NSInvocation *invocation) {
        
        void (^firstBlock)(NSArray *);
        [invocation getArgument:&firstBlock atIndex:2];
        
        firstBlock(expectedArray);
        
    }] downloadTimeTasksListWithCompletionHandler:OCMOCK_ANY failureHandler:OCMOCK_ANY];
    
    id mockHandler = [OCMockObject partialMockForObject: handler];
    [[mockHandler expect] setTableData:expectedArray];
    
    [unit viewDidAppear:NO];
    

    [mockHandler verify];
}

- (void) testThatAdmViewControllerReloadsTableViewWhenDownloadIsCompleted{

    [unit viewDidLoad];
    
    
    UITableView *tableView = [unit tableView];
    
    id mockTable = [OCMockObject partialMockForObject: tableView];
    [[mockTable expect] reloadData];
    
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    id mockConnector = [OCMockObject partialMockForObject: sharedConnector];
    
    __block NSArray *expectedArray = @[@"asd",@"lol"];
    
    [[[mockConnector expect] andDo:^(NSInvocation *invocation) {
        
        void (^firstBlock)(NSArray *);
        [invocation getArgument:&firstBlock atIndex:2];
        
        firstBlock(expectedArray);
        
    }] downloadTimeTasksListWithCompletionHandler:OCMOCK_ANY failureHandler:OCMOCK_ANY];
    
    [unit viewDidAppear: NO];
    
    [mockTable verify];

}


@end
