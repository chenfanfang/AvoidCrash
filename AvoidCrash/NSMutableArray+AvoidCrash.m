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
    
    //数组没有越界
    if (index < self.count) {
        return [self avoidCrashObjectAtIndex:index];
    }
    
    //数组越界
    else {
        [self dealWithObjectAtIndexErrorWithArrayCount:self.count index:index];
        
        return nil;
    }
}


- (void)dealWithObjectAtIndexErrorWithArrayCount:(NSUInteger)arrayCount index:(NSUInteger)index {
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = @"Get object from array error";
    NSString *errorReason = [NSString stringWithFormat:@"Index (%zd) beyond bounds [0...%zd].", index, arrayCount];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    NSString *defaultToDo = @"This framework default is to return nil.";
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n",AvoidCrashSeparatorWithFlag, errorInfo, errorReason, errorPlace, defaultToDo, AvoidCrashSeparator];
    
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorInfo        : errorInfo,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:errorInfoDic];
    
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array


- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {

    
    if (obj == nil) {
        [self dealWithSetObjectAtIndexObjectNilError];
    }
    
    else {
        //数组没有越界
        if (idx < self.count) {
            [self avoidCrashSetObject:obj atIndexedSubscript:idx];
        }
        
        //数组越界
        else {
            [self dealWithSetObjectAtIndexBeyondBoundsErrorWithArrayCount:self.count index:idx];
        }
    }
    

}


- (void)dealWithSetObjectAtIndexBeyondBoundsErrorWithArrayCount:(NSUInteger)arrayCount index:(NSUInteger)index {
    
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = @"NSMutableArray set object error:";
    NSString *errorReason = [NSString stringWithFormat:@"Index (%zd) beyond bounds [0...%zd].", index, arrayCount];
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    NSString *defaultToDo = @"This framework default is to ignore this operation to avoid crash.";
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n",AvoidCrashSeparatorWithFlag, errorInfo, errorReason, errorPlace, defaultToDo, AvoidCrashSeparator];
    
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorInfo        : errorInfo,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:errorInfoDic];
}


- (void)dealWithSetObjectAtIndexObjectNilError {
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = @"NSMutableArray set object error:";
    NSString *errorReason = @"[__NSArrayM setObject:atIndex:]: object cannot be nil";
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    NSString *defaultToDo = @"This framework default is to ignore this operation to avoid crash.";
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n",AvoidCrashSeparatorWithFlag, errorInfo, errorReason, errorPlace, defaultToDo, AvoidCrashSeparator];
    
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorInfo        : errorInfo,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:errorInfoDic];
    
}

//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    
    //数组没有越界
    if (index < self.count) {
        [self avoidCrashRemoveObjectAtIndex:index];
    }
    
    //数组越界
    else {
        
        [self dealWithRemoveObjectAtIndexErrorWithArrayCount:self.count index:index];
    }
}


- (void)dealWithRemoveObjectAtIndexErrorWithArrayCount:(NSUInteger)arrayCount index:(NSUInteger)index {
    
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = @"NSMutableArray remove object error:";
    NSString *errorReason = @"-[__NSArrayM removeObjectAtIndex:]: index %zd beyond bounds [0 .. %zd].";
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    NSString *defaultToDo = @"This framework default is to ignore this operation to avoid crash.";
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n",AvoidCrashSeparatorWithFlag, errorInfo, errorReason, errorPlace, defaultToDo, AvoidCrashSeparator];
    
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorInfo        : errorInfo,
                                   key_errorReason      : errorReason,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:errorInfoDic];
    
}


@end
