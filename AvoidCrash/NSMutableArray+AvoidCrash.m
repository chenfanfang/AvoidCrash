//
//  NSMutableArray+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableArray+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableArray (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    
    //get object from array method exchange
    Method objectAtIndex = class_getInstanceMethod(arrayMClass, @selector(objectAtIndex:));
    Method avoidCrashObjectAtIndex = class_getInstanceMethod(arrayMClass, @selector(avoidCrashObjectAtIndex:));
    method_exchangeImplementations(objectAtIndex, avoidCrashObjectAtIndex);
    
    //array set object at index
    Method setObject = class_getInstanceMethod(arrayMClass, @selector(setObject:atIndex:));
    Method avoidCrashSetObject = class_getInstanceMethod(arrayMClass, @selector(avoidCrashSetObject:atIndexedSubscript:));
    method_exchangeImplementations(setObject, avoidCrashSetObject);
    
    //removeObjectAtIndex:
    Method removeObjectAtIndex = class_getInstanceMethod(arrayMClass, @selector(removeObjectAtIndex:));
    Method avoidCrashRemoveObjectAtIndex = class_getInstanceMethod(arrayMClass, @selector(avoidCrashRemoveObjectAtIndex:));
    method_exchangeImplementations(removeObjectAtIndex, avoidCrashRemoveObjectAtIndex);
}


//=================================================================
//                   get object from array
//=================================================================
#pragma mark - get object from array


- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultReturnNil];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array

- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    @try {
        [self avoidCrashSetObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self avoidCrashRemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}



@end
