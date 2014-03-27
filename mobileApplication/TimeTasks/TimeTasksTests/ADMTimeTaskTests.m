//
//  ADMTimeTaskTests.m
//  TimeTasks
//
//  Created by Marco Musella on 24/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ADMTimeTask.h"



@interface ADMTimeTaskTests : XCTestCase{
    
    ADMTimeTask *unit;
    
    NSDictionary *mockDictionary;

}

@end

@implementation ADMTimeTaskTests

- (void)setUp
{
    [super setUp];
    
    if(!mockDictionary)
        mockDictionary = @{
                           @"id": @"1234",
                           @"description":@"Buy Milk",
                           @"time" : @120,
                           @"priority" : @1,
                           @"completed" : @YES
                           };
    
    unit = [[ADMTimeTask alloc] initWithDictionary: mockDictionary];
    
   

}

- (void)tearDown
{
    unit = nil;
    [super tearDown];
}


- (void) testThatTimeTaskCanBeInitializedWithADictionary{

    
    XCTAssertNotNil( unit, @"timetask should have been initalized with a dictionary");

}

- (void) testThatTimeTaskIsNotAcceptingNilDictionary{
    
    unit = nil;

    XCTAssertThrowsSpecificNamed(unit = [[ADMTimeTask alloc] initWithDictionary: nil], NSException, NSInternalInconsistencyException, @"timetask should not be accepting nil values");

}

- (void) testThatTimeTaskGetsAnId{

    XCTAssertTrue( [unit.objectId isEqualToString:@"1234"], @"timetask id should match passed one");
}

- (void) testThatTimeTaskGetsDescription{
    
    XCTAssertTrue([unit.description isEqualToString:@"Buy Milk"], @"timetask id should match passed one");
    
}

- (void) testThatTimeTaskGetsTime{

    XCTAssertEqual( unit.time, 120, @"timetask time should match passed one");

}

- (void) testThatTimeTaskGetsPriority{

    XCTAssertEqual( unit.priority, 1, @"timetask priority should match passed one");

}


- (void) testThatTimeTaskPriorityCannotBeNegative{

    unit.priority = -1;
    
    XCTAssertFalse( unit.priority < 0, @"timetask priority should be always greater or equal 0");

}

- (void) testThatTimeTaskPriorityCanBeTwo{
    
    unit.priority = 2;
    
    XCTAssertTrue( unit.priority == 2, @"timetask priority could be between 0 and 2");

}

- (void) testThatTimeTaskPriorityCannotBeGreaterThanTwo{
    
    unit.priority = 5;
    
    XCTAssertFalse( unit.priority > 2, @"timetask priority should be less or equal 2");

}

- (void) testThatTimeTaskPriorityDefaultsToOneWhenNotBetweenZeroAndTwo{

    unit.priority = 5;
    
    XCTAssertTrue( unit.priority == 1, @"timetask priority should be one by default");

}

- (void) testThatTimeTaskGetsCompleted{
    
    XCTAssertTrue( unit.completed , @"timetask completed flag should be true");
    
}





@end
