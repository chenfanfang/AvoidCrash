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
        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        
        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceDictionaryErrorMessage = [self getSetObjectErrorWithMainCallStackSymbolMsg:mainCallStackSymbolMsg];
        NSLog(@"%@",instanceDictionaryErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceDictionaryErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
    }
    
    else {
        [self avoidCrashSetObject:anObject forKey:aKey];
    }
    
}


- (NSString *)getSetObjectErrorWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg {
    
    NSMutableString *instanceDictionaryErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nNSMutableDictionary set object for key error:\ndictionary setObjectForKey: key cannot be nil\nThis framework default is to ignore this operation to avoid crash.\nError Place:%@:",AvoidCrashSeparator,AvoidCrashEnglishTitle, mainCallStackSymbolMsg];
    
    [instanceDictionaryErrorMessage appendFormat:@"\n%@\n可变字典set object for key出错:\n可变字典的setObjectForKey:的key不能为nil\n这个框架默认不进行setObjectForKey操作来避免崩溃。\n错误的地方:%@",AvoidCrashChineseTitle, mainCallStackSymbolMsg];
    [instanceDictionaryErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceDictionaryErrorMessage;
}


//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    if (aKey == nil) {
        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        
        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceDictionaryErrorMessage = [self getRemoveObjectForKeyErrorWithMainCallStackSymbolMsg:mainCallStackSymbolMsg];
        NSLog(@"%@",instanceDictionaryErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceDictionaryErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
    }
    
    else {
        [self avoidCrashRemoveObjectForKey:aKey];
    }
}


- (NSString *)getRemoveObjectForKeyErrorWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg {
    
    NSMutableString *instanceDictionaryErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nNSMutableDictionary remove object for key error:\nNSMutableDictionary removeObjectForKey: key cannot be nil\nThis framework default is to ignore this operation to avoid crash.\nError Place:%@:",AvoidCrashSeparator,AvoidCrashEnglishTitle, mainCallStackSymbolMsg];
    
    [instanceDictionaryErrorMessage appendFormat:@"\n%@\n可变字典remove object for key出错:\n可变字典的removeObjectForKey:的key不能为nil\n这个框架默认不进行removeObjectForKey操作来避免崩溃。\n错误的地方:%@",AvoidCrashChineseTitle, mainCallStackSymbolMsg];
    [instanceDictionaryErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceDictionaryErrorMessage;
}

@end
