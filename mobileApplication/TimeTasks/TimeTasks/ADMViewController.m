//
//  ADMViewController.m
//  TimeTasks
//
//  Created by Marco Musella on 24/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "ADMViewController.h"

#import "ADMTimeTasksConnector.h"
#import "ADMTableViewHandler.h"

@interface ADMViewController (){

    ADMTableViewHandler *_handler;
}


@end

@implementation ADMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"TimeTasks!";
    _handler = [ADMTableViewHandler new];
    _tableView.delegate = _handler;
    _tableView.dataSource = _handler;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:^(NSArray *taskList) {
        
        [_handler setTableData: taskList];
        [self.tableView reloadData];
        
    } failureHandler:nil];


}

@end
