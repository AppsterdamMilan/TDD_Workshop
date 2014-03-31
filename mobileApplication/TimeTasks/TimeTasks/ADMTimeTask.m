//
//  ADMTimeTask.m
//  TimeTasks
//
//  Created by Marco Musella on 24/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "ADMTimeTask.h"

@implementation ADMTimeTask

- (id) initWithDictionary:(NSDictionary *)dictionary{

    NSParameterAssert( dictionary != nil);
    
    if(self = [super init]){
        
        _objectId = dictionary[@"id"];
        _description = dictionary[@"description"];
        _time = [dictionary[@"time"] intValue];
        _priority = [dictionary[@"priority"] intValue];
        _completed = [dictionary[@"completed"] boolValue];
    
    }
    return self;

}

- (void) setPriority:(NSInteger)priority{

    if(priority <0)
        _priority = 1;
    else if (priority > 2)
        _priority = 1;
    else
        _priority = priority;
}

@end
