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
    
    NSMutableArray *errorIndexArrM = nil;
    for (NSUInteger index = 0; index < cnt; index++) {
        if (!(objects[index] && keys[index])) {
            if (errorIndexArrM == nil) {
                errorIndexArrM = [NSMutableArray array];
            }
            
            [errorIndexArrM addObject:@(index)];
        }
    }
    
    if (errorIndexArrM == nil) {
        return [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    
    else {
        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        
        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceDictionaryErrorMessage = [self getInstanceDictionaryErrorMessageWithMainCallStackSymbolMsg:mainCallStackSymbolMsg errorIndexArr:errorIndexArrM];
        
        NSLog(@"%@",instanceDictionaryErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceDictionaryErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
        
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


+ (NSString *)getInstanceDictionaryErrorMessageWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg errorIndexArr:(NSArray *)errorIndexArr {
    NSMutableString *instanceDictionaryErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nInstance a dictionary error:\nYou attempt to instance dictionary with nil objectValue or nil key .\nThis framework default is to remove nil key-values and instance a dictionary.\nError Place:%@\nnil key-value index in array:",AvoidCrashSeparator,AvoidCrashEnglishTitle,mainCallStackSymbolMsg];
    
    for (NSNumber *indexNumber in errorIndexArr) {
        [instanceDictionaryErrorMessage appendFormat:@"(%@)",indexNumber];
    }
    
    [instanceDictionaryErrorMessage appendFormat:@"\n%@\n创建一个字典出错:\n你要创建的字典的key或者value里面包含nil.\n这个框架默认的做法是移除所有为nil的key和value,然后实例化一个字典。\n错误的地方:%@\nnil的key或者value在字典中的位置:",AvoidCrashChineseTitle, mainCallStackSymbolMsg];
    
    for (NSNumber *indexNumber in errorIndexArr) {
        [instanceDictionaryErrorMessage appendFormat:@"(%@)",indexNumber];
    }
    
    [instanceDictionaryErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceDictionaryErrorMessage;
}

@end
