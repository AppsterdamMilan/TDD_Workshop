//
//  ADMTimeTask.h
//  TimeTasks
//
//  Created by Marco Musella on 24/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADMTimeTask : NSObject


@property (nonatomic, readonly) NSString *objectId;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) BOOL completed;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
