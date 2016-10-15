//
//  NSArray+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSArray+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSArray (AvoidCrash)


+ (void)avoidCrashExchangeMethod {
    
    //class method
    
    //instance array method exchange
    [AvoidCrash exchangeClassMethod:[self class] method1Sel:@selector(arrayWithObjects:count:) method2Sel:@selector(AvoidCrashArrayWithObjects:count:)];
    
    
    
    //instance method
    
    Class __NSArray = NSClassFromString(@"NSArray");
    
    //objectAtIndexedSubscript:
    //这个方法的交换，也附带了防止objectAtIndex: 的崩溃
    [AvoidCrash exchangeInstanceMethod:__NSArray method1Sel:@selector(objectAtIndexedSubscript:) method2Sel:@selector(avoidCrashObjectAtIndexedSubscript:)];
}


//=================================================================
//                        instance array
//=================================================================
#pragma mark - instance array


+ (instancetype)AvoidCrashArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to remove nil object and instance a array.";
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self AvoidCrashArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}



//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }

}




@end
