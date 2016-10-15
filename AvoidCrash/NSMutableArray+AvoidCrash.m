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
    //由于继承于NSArray，所以 objectAtIndexedSubscript已经在NSArray中处理过了，无需处理
    
    //array set object at index
    [AvoidCrash exchangeInstanceMethod:arrayMClass method1Sel:@selector(setObject:atIndexedSubscript:) method2Sel:@selector(avoidCrashSetObject:atIndexedSubscript:)];
    
    
    //removeObjectAtIndex:
    [AvoidCrash exchangeInstanceMethod:arrayMClass method1Sel:@selector(removeObjectAtIndex:) method2Sel:@selector(avoidCrashRemoveObjectAtIndex:)];
    
    //insertObject:atIndex:
    [AvoidCrash exchangeInstanceMethod:arrayMClass method1Sel:@selector(insertObject:atIndex:) method2Sel:@selector(avoidCrashInsertObject:atIndex:)];
    
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


//=================================================================
//                    insertObject:atIndex:
//=================================================================
#pragma mark - set方法
- (void)avoidCrashInsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self avoidCrashInsertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}



@end
