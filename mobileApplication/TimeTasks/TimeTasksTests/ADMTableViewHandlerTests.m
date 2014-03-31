//
//  ADMTableViewHandlerTests.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ADMTableViewHandler.h"

//participants
#import "ADMTableViewCell.h"
#import "ADMViewController.h"
#import "ADMTimeTask.h"
#import <OCMock/OCMock.h>

@interface ADMTableViewHandlerTests : XCTestCase{

    ADMTableViewHandler *unit;
    ADMViewController *vc;
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
    unit = nil;
    vc = nil;
    [super tearDown];
}


- (void)setMockTableData {
    
    NSDictionary *rawTask = @{
                              @"id": @"1234",
                              @"description":@"Buy Milk",
                              @"time" : @120,
                              @"priority" : @1,
                              @"completed" : @YES
                              };
    
    ADMTimeTask *newTask = [[ADMTimeTask alloc] initWithDictionary:rawTask];
    
    NSArray *mockData = @[newTask];
    
    unit.tableData = mockData;
}

- (void)hookHandlerToViewController {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ADMViewControllerIdentifier"];
    
    [vc performSelector:@selector(loadView) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];

    
    [vc viewDidLoad];
    vc.tableView.delegate = unit;
    vc.tableView.dataSource = unit;
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

- (void) testThatHandlerReturnsAnAdmTableViewCell{

    [self setMockTableData];
    
    [self hookHandlerToViewController];
    
    id returnedCell = [unit tableView:vc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssertTrue( [returnedCell isKindOfClass:[ADMTableViewCell class]], @"returned cell should be an ADMTableViewCell");
}

- (void) testThatHandlerMakesCellDrawForSpecificTask{
    
    [self setMockTableData];
    
    [self hookHandlerToViewController];

    ADMTableViewCell *cell = (ADMTableViewCell *)[unit tableView: vc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssertTrue([cell.taskDescriptionLabel.text isEqualToString:@"Buy Milk"], @"unit should have drawn cell for specific task");

}

- (void) testThatSelectingCellNotCompletedTaskCompletesTheTask{

    [self setMockTableData];
    [self hookHandlerToViewController];
    
    [[unit.tableData objectAtIndex:0] setCompleted: NO];
    
    [unit tableView:vc.tableView didSelectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssertTrue( [[unit.tableData objectAtIndex:0] completed], @"selecting a row with an uncomplete task should have completed it");

}

//TODO: provare con ocmock
- (void) testThatSelectingNotCompletedTaskChecksTheCellCell{

    [self setMockTableData];
    [self hookHandlerToViewController];
    
    [[unit.tableData objectAtIndex:0 ] setCompleted: NO];
    
    ADMTableViewCell *cell = (ADMTableViewCell *)[unit tableView:vc.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    [cell setChecked: NO];
    
    NSData *notCheckedImageData = UIImagePNGRepresentation(cell.taskCheckBoxImageView.image);
    
    [unit tableView:vc.tableView didSelectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    cell = (ADMTableViewCell *)[unit tableView:vc.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSData *checkedImageData = UIImagePNGRepresentation(cell.taskCheckBoxImageView.image);
    
    XCTAssertFalse( [notCheckedImageData isEqualToData:checkedImageData], @"cell should have been checked");

}

- (void) testThatSelectingCellCompletedTaskUncompletesTheTask{

    [self setMockTableData];
    [self hookHandlerToViewController];
    
    [unit tableView:vc.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    XCTAssertTrue( ![[unit.tableData objectAtIndex:0] completed], @"selecting a row with a complete task should have uncomplete it");

}

- (void) testThatSelectingCompletedTaskUnchecksTheCellCell{
    
    [self setMockTableData];
    [self hookHandlerToViewController];
    
    ADMTableViewCell *cell = (ADMTableViewCell *)[unit tableView:vc.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    

    NSData *checkedImageData = UIImagePNGRepresentation(cell.taskCheckBoxImageView.image);
    
    [unit tableView:vc.tableView didSelectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    cell = (ADMTableViewCell *)[unit tableView:vc.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    
    NSData *notCheckedImageData = UIImagePNGRepresentation(cell.taskCheckBoxImageView.image);

    
    XCTAssertFalse( [notCheckedImageData isEqualToData:checkedImageData], @"cell should have been checked");
    
}





@end
