//
//  ADMTimeTasksConnector.m
//  TimeTasks
//
//  Created by Marco Musella on 26/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "ADMTimeTasksConnector.h"

#import "ADMTimeTask.h"

#define kBaseUrl @"http://localhost:8080/"
#define kTaskListApi @"timeTasks"


@interface ADMTimeTasksConnector (){


    NSURLRequest *_urlRequest;
}

@end

@implementation ADMTimeTasksConnector

+ (ADMTimeTasksConnector *) sharedConnector{

    static ADMTimeTasksConnector *_sharedConnector = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConnector = [ADMTimeTasksConnector new];
    });
    
    return _sharedConnector;

}

- (void) downloadTimeTasksListWithCompletionHandler: (void(^)(NSArray *taskList)) completionHandler failureHandler: (void (^)(NSError *error)) failureHandler{

    _urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseUrl, kTaskListApi]]];
    
    
    [NSURLConnection sendAsynchronousRequest: _urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSHTTPURLResponse *_response = (NSHTTPURLResponse *) response;
        
        
        
        if(!connectionError && _response.statusCode == 200){
            
            NSError *_error=nil;
            NSArray *rawTasks = [NSJSONSerialization JSONObjectWithData:data options:0 error:&_error];
            
            NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:[rawTasks count]];
            
            if(!_error){
                
                for (NSDictionary *rawTask in rawTasks) {
                    
                    ADMTimeTask *newTask = [[ADMTimeTask alloc] initWithDictionary: rawTask];
                    
                    [tmp addObject: newTask];
                    
                    
                }
                
                if(completionHandler)
                    completionHandler([NSArray arrayWithArray: tmp]);
                
            }
            else
                failureHandler(_error);
            
        }
        else{
        
            if(failureHandler)
                failureHandler(connectionError);
        }
            

        
        
    }];    
    

}

@end
