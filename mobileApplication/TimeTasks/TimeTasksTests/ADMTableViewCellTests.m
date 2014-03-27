//
//  ADMTableViewCellTests.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ADMTableViewCell.h"

//participants
#import "ADMTimeTask.h"
#import "ADMViewController.h"
#import "ADMTableViewHandler.h"

@interface ADMTableViewCellTests : XCTestCase{

    ADMTableViewCell *cell;
    ADMTableViewHandler *handler;
    ADMViewController *vc;

}

@end

@implementation ADMTableViewCellTests

- (void)setUp
{
    [super setUp];
    
    cell = [self obtainCellFromPrototypesInStoryboard];
}

- (void)tearDown
{
    cell = nil;
    [super tearDown];
}

- (ADMTimeTask *) getMockTask{

    NSDictionary *rawTask = @{
                              @"id": @"1234",
                              @"description":@"Buy Milk",
                              @"time" : @120,
                              @"priority" : @1,
                              @"completed" : @YES
                              };
    
    ADMTimeTask *newTask = [[ADMTimeTask alloc] initWithDictionary:rawTask];
    
    return newTask;

}

- (ADMTableViewCell *) obtainCellFromPrototypesInStoryboard{

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ADMViewControllerIdentifier"];
    
    [vc performSelector:@selector(loadView) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
    
    [vc viewDidLoad];
    
    handler = [ADMTableViewHandler new];
    
    handler.tableData = @[[self getMockTask]];
    
    vc.tableView.dataSource = handler;
    vc.tableView.delegate = handler;
    
    return (ADMTableViewCell *)[handler tableView: vc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

}


- (void) testThatCellHasTaskDescroptionLabel{

    
    XCTAssertTrue( [cell respondsToSelector:@selector(taskDescriptionLabel)], @"cell should expose a task description uilabel");

}

- (void) testThatCellHasTaskExpectedMinutesLabel{
    
    
    XCTAssertTrue( [cell respondsToSelector:@selector(taskExpectedMinutesLabel)], @"cell should expose an expected minutes uilabel");
    
}

- (void) testThatCellHasTaskPriorityLabel{

    
    XCTAssertTrue( [cell respondsToSelector:@selector(taskPriorityLabel)], @"cell should expose a task priority uilabel");
}

- (void) testThatCellHasTaskCheckBoxImageView{
    
    XCTAssertTrue( [cell respondsToSelector:@selector(taskCheckBoxImageView)], @"cell should expose a task checkbox imageview");

}

- (void) testThatCellDrawsForSpecificTask{

    ADMTimeTask *newTask = [self getMockTask];
    newTask.description = @"New Description";
    [cell drawForTask: newTask];
    
    UIImage *expectedImage = [UIImage imageNamed:@"checkbox_checked"];
    UIImage *actualImage = cell.taskCheckBoxImageView.image;
    
    NSData *expectedImageData = UIImagePNGRepresentation(expectedImage);
    NSData *actualImageData = UIImagePNGRepresentation(actualImage);
    
    BOOL condition = ([cell.taskDescriptionLabel.text isEqualToString: @"New Description"] &&
                      [cell.taskExpectedMinutesLabel.text isEqualToString:@"120"] &&
                      [cell.taskPriorityLabel.text isEqualToString:@"1"] &&
                      [expectedImageData isEqualToData: actualImageData]
                      );
    
    XCTAssertTrue( condition, @"cell should have drawn for passed task");
    

}

- (void) testThatCellGetsUncheked{

    [cell drawForTask: [self getMockTask]];
    
    
    [cell setChecked: NO];
    
    NSData *expectedImageData = UIImagePNGRepresentation([UIImage imageNamed:@"checkbox"]);
    NSData *actualImageData = UIImagePNGRepresentation(cell.taskCheckBoxImageView.image);
    
    XCTAssertTrue( [expectedImageData isEqualToData: actualImageData] , @"cell should have unchecked image set");

}

- (void) testThatCellGetsChecked{

    ADMTimeTask *newTask = [self getMockTask];
    newTask.completed = NO;
    
    [cell drawForTask: newTask];
    [cell setChecked:YES];
    
    NSData *expectedImageData = UIImagePNGRepresentation([UIImage imageNamed:@"checkbox_checked"]);
    NSData *actualImageData = UIImagePNGRepresentation(cell.taskCheckBoxImageView.image);
    
    XCTAssertTrue( [expectedImageData isEqualToData: actualImageData] , @"cell should have checked image set");


}



@end
