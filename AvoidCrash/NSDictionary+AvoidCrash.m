//
//  NSDictionary+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSDictionary+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSDictionary (AvoidCrash)

+ (void)load {
    Method dictionaryWithObjects = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method avoidCrashDictionaryWithObjects = class_getClassMethod(self, @selector(avoidCrashDictionaryWithObjects:forKeys:count:));
    
    method_exchangeImplementations(dictionaryWithObjects, avoidCrashDictionaryWithObjects);
    
}

+ (instancetype)avoidCrashDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    //用来标记key 或者 value 为nil 的的下标
    
    NSMutableArray *errorIndexArrM = nil;
    
    for (NSUInteger index = 0; index < cnt; index++) {
        if (!(objects[index] && keys[index])) {
            if (errorIndexArrM == nil) {
                errorIndexArrM = [NSMutableArray array];
            }
            
            [errorIndexArrM addObject:@(index)];
        }
    }
    
    //创建字典的数据正常
    if (errorIndexArrM == nil) {
        return [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    
    //创建字典的数据不正常
    else {
        
        [self dealWithInstanceDictionaryErrorMessageWithErrorIndexArr:errorIndexArrM];
        
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger count = cnt - errorIndexArrM.count;
        id  _Nonnull __unsafe_unretained tempObjects[count];
        id  _Nonnull __unsafe_unretained tempkeys[count];
        
        int delta = 0;
        for (int i = 0; i < count; i++) {
            while (objects[delta + i] == nil || keys[delta + i]) {
                delta ++;
            }
            
            tempObjects[i] = objects[delta + i];
            tempkeys[i] = keys[delta + i];
            
        }
        return [self avoidCrashDictionaryWithObjects:tempObjects forKeys:tempkeys count:count];
    }
}


+ (void)dealWithInstanceDictionaryErrorMessageWithErrorIndexArr:(NSArray *)errorIndexArr {
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = [NSString stringWithFormat:@"Instance a dictionary error:"];
    NSString *errorReason = @"You attempt to instance dictionary with nil objectValue or nil key .";
    NSMutableString *errorDetail = [NSMutableString stringWithFormat:@"nil key-value index in array:"];
    for (NSNumber *indexNumber in errorIndexArr) {
        [errorDetail appendFormat:@"(%@)",indexNumber];
    }
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    NSString *defaultToDo = @"This framework default is to remove nil key-values and instance a dictionary.";
    
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n%@\n\n%@\n\n",AvoidCrashSeparatorWithFlag, errorInfo, errorReason, errorDetail, errorPlace, defaultToDo, AvoidCrashSeparator];
    NSLog(@"%@", logErrorMessage);
    
    NSDictionary *errorInfoDic = @{
                                   key_errorInfo        : errorInfo,
                                   key_errorReason      : errorReason,
                                   key_errorDetail      : errorDetail,
                                   key_errorPlace       : errorPlace,
                                   key_defaultToDo      : defaultToDo,
                                   key_callStackSymbols : callStackSymbolsArr
                                   };
    
    //将错误信息放在字典里，用通知的形式发送出去
    [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:errorInfoDic];
    
}

@end
