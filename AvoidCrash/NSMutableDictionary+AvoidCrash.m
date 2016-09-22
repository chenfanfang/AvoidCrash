//
//  NSMutableDictionary+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableDictionary+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableDictionary (AvoidCrash)

+ (void)load {
    Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
    
    
    //setObject:forKey:
    Method setObject = class_getInstanceMethod(dictionaryM, @selector(setObject:forKey:));
    Method avoidCrashSetObject = class_getInstanceMethod(dictionaryM, @selector(avoidCrashSetObject:forKey:));
    method_exchangeImplementations(setObject, avoidCrashSetObject);
    
    //removeObjectForKey:
    Method removeObjectForKey = class_getInstanceMethod(dictionaryM, @selector(removeObjectForKey:));
    Method avoidCrashRemoveObjectForKey = class_getInstanceMethod(dictionaryM, @selector(avoidCrashRemoveObjectForKey:));
    method_exchangeImplementations(removeObjectForKey, avoidCrashRemoveObjectForKey);
}


//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - set方法

- (void)avoidCrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (aKey == nil) {
        
        [self dealWithSetObjectError];
    }
    
    else {
        [self avoidCrashSetObject:anObject forKey:aKey];
    }
    
}


- (void)dealWithSetObjectError {
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = @"NSMutableDictionary set object for key error:";
    NSString *errorReason = @"dictionary setObjectForKey: key cannot be nil";
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
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    
    if (aKey == nil) {
        
        [self dealWithRemoveObjectForKeyError];
    }
    
    else {
        [self avoidCrashRemoveObjectForKey:aKey];
    }
}


- (void)dealWithRemoveObjectForKeyError {
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = @"NSMutableDictionary remove object for key error:";
    NSString *errorReason = @"NSMutableDictionary removeObjectForKey: key cannot be nil";
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
