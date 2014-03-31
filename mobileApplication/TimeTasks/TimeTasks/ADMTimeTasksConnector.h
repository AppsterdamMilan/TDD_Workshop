//
//  ADMTimeTasksConnector.h
//  TimeTasks
//
//  Created by Marco Musella on 26/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADMTimeTasksConnector : NSObject <NSURLConnectionDataDelegate>

+ (ADMTimeTasksConnector *) sharedConnector;

- (void) downloadTimeTasksListWithCompletionHandler: (void(^)(NSArray *taskList)) completionHandler failureHandler: (void (^)(NSError *error)) failureHandler;

@end
