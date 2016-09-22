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

+ (void)load {
    
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
    if (index < self.count) {
        return [self avoidCrashObjectAtIndex:index];
    }
    
    else {
        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        
        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceArrayErrorMessage = [self getObjectAtIndexErrorWithMainCallStackSymbolMsg:mainCallStackSymbolMsg arrayCount:self.count index:index];
        NSLog(@"%@",instanceArrayErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceArrayErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
        
        return nil;
    }
}


- (NSString *)getObjectAtIndexErrorWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg arrayCount:(NSUInteger)arrayCount index:(NSUInteger)index {
    
    NSMutableString *instanceArrayErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nGet object from array error:\nIndex (%zd) beyond bounds [0...%zd]..\nThis framework default is to return nil.\nError Place:%@:",AvoidCrashSeparator,AvoidCrashEnglishTitle, index, arrayCount, mainCallStackSymbolMsg];
    
    [instanceArrayErrorMessage appendFormat:@"\n%@\n从数组中获取元素出错:\n下标(%zd)越界[0...%zd].\n这个框架默认的做法是返回一个nil。\n错误的地方:%@",AvoidCrashChineseTitle, index, arrayCount, mainCallStackSymbolMsg];
    [instanceArrayErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceArrayErrorMessage;
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array


- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj == nil) {
        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        
        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceArrayErrorMessage = [self getSetObjectAtIndexObjectNilErrorWithMainCallStackSymbolMsg:mainCallStackSymbolMsg];
        NSLog(@"%@",instanceArrayErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceArrayErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
    }
    
    else {
        
        if (idx < self.count) {
            [self avoidCrashSetObject:obj atIndexedSubscript:idx];
        }
        
        else {
            //错误信息函数调用栈主要信息的获取
            NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
            
            NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
            
            NSString *instanceArrayErrorMessage = [self getSetObjectAtIndexBeyondBoundsErrorWithMainCallStackSymbolMsg:mainCallStackSymbolMsg arrayCount:self.count index:idx];
            NSLog(@"%@",instanceArrayErrorMessage);
            
            NSDictionary *userInfo = @{
                                       AvoidCrash_Key_ErrorMainMessage : instanceArrayErrorMessage,
                                       AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                       };
            [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
        }
    }
    

}


- (NSString *)getSetObjectAtIndexBeyondBoundsErrorWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg arrayCount:(NSUInteger)arrayCount index:(NSUInteger)index {
    
    NSMutableString *instanceArrayErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nNsmutableArray set object error:\nIndex (%zd) beyond bounds [0...%zd]..\nThis framework default is to ignore this operation to avoid crash.\nError Place:%@:",AvoidCrashSeparator,AvoidCrashEnglishTitle, index, arrayCount, mainCallStackSymbolMsg];
    
    [instanceArrayErrorMessage appendFormat:@"\n%@\n可变数组赋值出错:\n下标(%zd)越界[0...%zd].\n这个框架默认不做赋值处理来防止崩溃。\n错误的地方:%@",AvoidCrashChineseTitle, index, arrayCount, mainCallStackSymbolMsg];
    [instanceArrayErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceArrayErrorMessage;
}


- (NSString *)getSetObjectAtIndexObjectNilErrorWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg {
    
    NSMutableString *instanceArrayErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nNSMutableArray set object error:\n[__NSArrayM setObject:atIndex:]: object cannot be nil\nThis framework default is to ignore this operation to avoid crash.\nError Place:%@:",AvoidCrashSeparator,AvoidCrashEnglishTitle,mainCallStackSymbolMsg];
    
    [instanceArrayErrorMessage appendFormat:@"\n%@\n可变数组赋值出错:\n赋值的object不能为nil.\n这个框架默认不做赋值处理来防止崩溃。\n错误的地方:%@",AvoidCrashChineseTitle,mainCallStackSymbolMsg];
    [instanceArrayErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceArrayErrorMessage;
}

//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self avoidCrashRemoveObjectAtIndex:index];
    }
    
    else {
        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        
        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceArrayErrorMessage = [self getRemoveObjectAtIndexErrorWithMainCallStackSymbolMsg:mainCallStackSymbolMsg arrayCount:self.count index:index];
        NSLog(@"%@",instanceArrayErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceArrayErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
    }
}


- (NSString *)getRemoveObjectAtIndexErrorWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg arrayCount:(NSUInteger)arrayCount index:(NSUInteger)index {
    
    NSMutableString *instanceArrayErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nNSMutableArray remove object error:\n-[__NSArrayM removeObjectAtIndex:]: index %zd beyond bounds [0 .. %zd].\nThis framework default is to ignore this operation to avoid crash.\nError Place:%@:",AvoidCrashSeparator,AvoidCrashEnglishTitle, index, arrayCount, mainCallStackSymbolMsg];
    
    [instanceArrayErrorMessage appendFormat:@"\n%@\n可变数组移除元素出错:\n-[__NSArrayM removeObjectAtIndex:]: index %zd beyond bounds [0 .. %zd].\n这个框架默认不做赋值处理来防止崩溃。\n错误的地方:%@",AvoidCrashChineseTitle, index, arrayCount, mainCallStackSymbolMsg];
    [instanceArrayErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceArrayErrorMessage;
}


@end
