//
//  ADMViewController.m
//  TimeTasks
//
//  Created by Marco Musella on 24/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "ADMViewController.h"

#import "ADMTimeTasksConnector.h"

@interface ADMViewController ()

@end

@implementation ADMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:nil failureHandler:nil];

}

@end
