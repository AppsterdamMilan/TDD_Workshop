//
//  XCTestCase+ADMTestingExtensions.m
//  TimeTasks
//
//  Created by Marco Musella on 26/03/14.
//  Copyright (c) 2014 Mush. All rights reserved.
//

#import "XCTestCase+ADMTestingExtensions.h"

static const char boolValuePayloadKey;

@implementation XCTestCase (ADMTestingExtensions)

+ (void) swapInstanceMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2 {
    
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    
    method_exchangeImplementations(method1, method2);
}

+ (void) swapClassMethodsForClass:(Class) cls selector: (SEL) sel1 andSelector: (SEL) sel2 {
    
    Method method1 = class_getClassMethod(cls, sel1);
    Method method2 = class_getClassMethod(cls, sel2);
    
    cls = object_getClass((id)cls);
    
    if(class_addMethod(cls, sel1, method_getImplementation(method2), method_getTypeEncoding(method2)))
        class_replaceMethod(cls, sel2, method_getImplementation(method1), method_getTypeEncoding(method1));
    else
        method_exchangeImplementations(method1, method2);
}

+ (void) addBoolPayloadToObject: (id) object boolValue: (BOOL) value{
    
    NSNumber *payload = [NSNumber numberWithBool: value];
    objc_setAssociatedObject( object, &boolValuePayloadKey, payload, OBJC_ASSOCIATION_RETAIN);
    
    
}

+ (BOOL) getBoolPayloadFromObject: (id) object{
    
    NSNumber *payload = objc_getAssociatedObject( object, &boolValuePayloadKey);
    
    return [payload boolValue];
    
}

@end
