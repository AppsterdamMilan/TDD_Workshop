//
//  ADMTableViewHandler.h
//  TimeTasks
//
//  Created by Marco Musella on 27/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADMTableViewHandler : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *tableData;

@end
