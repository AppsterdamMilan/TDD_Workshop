//
//  ADMTimeTasksConnectorTests.m
//  TimeTasks
//
//  Created by Marco Musella on 26/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ADMTimeTasksConnector.h"

//utility
#import "XCTestCase+ADMTestingExtensions.h"
#import "ADMTimeTask.h"


@implementation NSURLConnection (TestingExtensions)

+ (void) fake_sendAsynchronousRequest:(NSURLRequest *)request
                                queue:(NSOperationQueue *)queue
                    completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler{

    NSArray *mockModel = @[
                           @{
                               @"id":@"133421",
                               @"description":@"Buy chocolate",
                               @"time":@30,
                               @"priority":@2,
                               @"due":@1395068086,
                               @"completed":@NO,
                               @"lastUpdate":@1395064566
                               },
                           @{
                               @"id":@"133422",
                               @"description":@"Buy milk",
                               @"time":@20,
                               @"priority":@1,
                               @"due":@1395068086,
                               @"completed":@NO,
                               @"lastUpdate":@1395064566
                               }
                           
                           ];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mockModel options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:200 HTTPVersion:nil headerFields:nil];
    
    
    handler(response,jsonData,nil);

}

+ (void) fake_malformedJson_sendAsynchronousRequest:(NSURLRequest *)request
                                queue:(NSOperationQueue *)queue
                    completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler{
    
    
    NSString *malformedJson = @"I'm a malformed json string";
    
    NSData *jsonData = [malformedJson dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:200 HTTPVersion:nil headerFields:nil];
    
    
    handler(response,jsonData,nil);
    
}


+ (void) fake_failing_fourohfour_sendAsynchronousRequest:(NSURLRequest *)request
                                queue:(NSOperationQueue *)queue
                    completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler{
    
    
    NSData *jsonData = nil;
    
    
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:nil statusCode:404 HTTPVersion:nil headerFields:nil];
    
    NSError *mockError = [NSError errorWithDomain:@"mock error" code:404 userInfo:nil];
    
    handler(response,jsonData,mockError);
    
}


@end

@interface ADMTimeTasksConnectorTests : XCTestCase

@end

@implementation ADMTimeTasksConnectorTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) swapSuccessfulUrlConnectionMethods{

    [XCTestCase swapClassMethodsForClass:[NSURLConnection class] selector:@selector(sendAsynchronousRequest:queue:completionHandler:) andSelector:@selector(fake_sendAsynchronousRequest:queue:completionHandler:)];

}

- (void) swapSuccessfulUrlConnectionWithMalformedJsonMethods{
    
    [XCTestCase swapClassMethodsForClass:[NSURLConnection class] selector:@selector(sendAsynchronousRequest:queue:completionHandler:) andSelector:@selector(fake_malformedJson_sendAsynchronousRequest:queue:completionHandler:)];
    
}

- (void) swapFailingFourOhFourUrlConnectionMethods{
    
    [XCTestCase swapClassMethodsForClass:[NSURLConnection class] selector:@selector(sendAsynchronousRequest:queue:completionHandler:) andSelector:@selector(fake_failing_fourohfour_sendAsynchronousRequest:queue:completionHandler:)];
    
}


- (void) testThatClassMethodReturnsTimeTasksConnector{

    ADMTimeTasksConnector *connector = [ADMTimeTasksConnector sharedConnector];
    
    XCTAssertNotNil( connector, @"connector should have been returned");

}

- (void) testThatConnectorIsSingleton{

    ADMTimeTasksConnector *one = [ADMTimeTasksConnector sharedConnector];
    ADMTimeTasksConnector *two = [ADMTimeTasksConnector sharedConnector];
    
    XCTAssertEqualObjects( one, two, @"returned objects should be the same");
}

- (void) testThatConnectorIsNSUrlConnectionDataDelegate{

    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];

    XCTAssertTrue( [sharedConnector conformsToProtocol:@protocol(NSURLConnectionDataDelegate)], @"connector should be a nsurlconnection delegate");
}

- (void) testThatConnectorExecutesCompletionHandlerOnSuccesfulTaskRequest{
    
    [self swapSuccessfulUrlConnectionMethods];
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    __block BOOL executed = NO;
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:^(NSArray *taskList) {
        
        executed = YES;
        
    } failureHandler:nil];

    
    XCTAssertTrue( executed, @"connector completion handler should have been executed");
    
    
    [self swapSuccessfulUrlConnectionMethods];

}

- (void) testThatConnectorDownloadTaskStartsAnUrlRequestWithRightApiURL{
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:nil failureHandler:nil];
    
    NSURLRequest *request = [sharedConnector valueForKey:@"_urlRequest"];
    NSString *apiURLString = [[request URL] absoluteString];
    
    XCTAssertTrue( [apiURLString isEqualToString:@"http://timetasks.appsterdammilan.com/timeTasks"] || [apiURLString isEqualToString:@"http://localhost:8080/timeTasks"], @"connector url should have selected right api url for tasklist download");
    
}


- (void) testThatConnectorDownloadsNewTaskListIfConnectionSuccessful{
    
    
    [self swapSuccessfulUrlConnectionMethods];
    
    __block NSArray *items;
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:^(NSArray *taskList) {
        
        items = taskList;
        
    } failureHandler:nil];
    
    
    BOOL allTimeTasks = YES;
    
    for (id item in items) {
        
        if (![item isKindOfClass:[ADMTimeTask class]])
            allTimeTasks = NO;
        
        
    }
    
    
    XCTAssertTrue( allTimeTasks, @"returned array should contain timetasks");

    [self swapSuccessfulUrlConnectionMethods];

}

- (void) testThatConnectorExecutesFailureHandlerOnFailingFourOhFourTaskRequest{
    
    [self swapFailingFourOhFourUrlConnectionMethods];
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    __block BOOL executed = NO;
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:nil failureHandler:^(NSError *error) {
        
        executed = YES;
    }];
    
    XCTAssertTrue( executed, @"connector completion handler should have been executed");
    
    [self swapFailingFourOhFourUrlConnectionMethods];
    
}

- (void) testThatConnectorExecutesFailureHandlerOnMalformedJson{

    [self swapSuccessfulUrlConnectionWithMalformedJsonMethods];
    
    ADMTimeTasksConnector *sharedConnector = [ADMTimeTasksConnector sharedConnector];
    
    __block BOOL executed = NO;
    
    [sharedConnector downloadTimeTasksListWithCompletionHandler:nil failureHandler:^(NSError *error) {
        
        executed = YES;
    }];
    
    XCTAssertTrue( executed, @"connector completion handler should have been executed");
    
    [self swapFailingFourOhFourUrlConnectionMethods];

}



@end
