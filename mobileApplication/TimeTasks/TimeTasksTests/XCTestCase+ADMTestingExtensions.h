//
//  XCTestCase+ADMTestingExtensions.h
//  TimeTasks
//
//  Created by Marco Musella on 26/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import <objc/message.h>


@interface XCTestCase (ADMTestingExtensions)

+ (void) swapInstanceMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2;
+ (void) swapClassMethodsForClass:(Class) cls selector: (SEL) sel1 andSelector: (SEL) sel2;
+ (void) addBoolPayloadToObject: (id) object boolValue: (BOOL) value;
+ (BOOL) getBoolPayloadFromObject: (id) object;

@end
