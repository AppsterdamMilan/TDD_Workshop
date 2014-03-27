//
//  ADMTableViewHandlerTests.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ADMTableViewHandler.h"

@interface ADMTableViewHandlerTests : XCTestCase{

    ADMTableViewHandler *unit;
}

@end

@implementation ADMTableViewHandlerTests

- (void)setUp
{
    [super setUp];
    unit = [ADMTableViewHandler new];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatHandlerIsTableViewDelegate{

    
    XCTAssertTrue([unit conformsToProtocol:@protocol(UITableViewDelegate)], @"unit should be a tableview delegate");
}

- (void) testThatHandlerIsTableViewDatasource{

    
    XCTAssertTrue([unit conformsToProtocol:@protocol(UITableViewDataSource)], @"unit should be a tableview datasource");
}

- (void) testThatHandlerHasTableDataProperty{

    
   XCTAssertTrue([unit respondsToSelector:@selector(tableData)], @"unit should expose a tableData array");

}

- (void) testThatHandlerTableDataIsNotNil{

    XCTAssertNotNil( unit.tableData, @"unit'stableData should be initialized and empty");

}

- (void) testThatHandlerReturnsJustOneSection{

    NSInteger sections = [unit numberOfSectionsInTableView:nil];
    
    XCTAssertEqual( sections, 1, @"unit should return exactly one section");

}

- (void) testThatHandlerReturnsTableDataCountRows{

    NSArray *mockData = @[@"1",@"2",@"3",@"4"];
    
    unit.tableData = mockData;
    
    NSInteger rows = [unit tableView:nil numberOfRowsInSection:1];
    
    XCTAssertEqual(rows, [mockData count], @"unit should return number of rows equal to tabledata count");

}

@end
