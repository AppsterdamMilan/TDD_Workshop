//
//  ADMTableViewHandler.m
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "ADMTableViewHandler.h"


#import "ADMTableViewCell.h"
#import "ADMTimeTask.h"

@implementation ADMTableViewHandler

- (id)init
{
    self = [super init];
    if (self) {
        self.tableData = @[];
    }
    return self;
}


#pragma mark - TableView Delegate and Datasource Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{


    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return [_tableData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"ADMTableViewCellIdentifier";
    
    ADMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell drawForTask: [_tableData objectAtIndex:indexPath.row]];
    
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ADMTimeTask *thisTask = [self.tableData objectAtIndex:indexPath.row];
    BOOL completed = [thisTask completed];
    thisTask.completed = !completed;
    
    [tableView reloadData];
}

@end
