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

+ (void)load {
    
    //instance array method exchange
    Method arrayWithObjects = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method avoidCrashArrayWithObjects = class_getClassMethod(self, @selector(AvoidCrashArrayWithObjects:count:));
    method_exchangeImplementations(arrayWithObjects, avoidCrashArrayWithObjects);
    
    
    Class arrayIClass = NSClassFromString(@"__NSArrayI");
    
    //get object from array method exchange
    Method objectAtIndex = class_getInstanceMethod(arrayIClass, @selector(objectAtIndex:));
    Method avoidCrashObjectAtIndex = class_getInstanceMethod(arrayIClass, @selector(avoidCrashObjectAtIndex:));
    method_exchangeImplementations(objectAtIndex, avoidCrashObjectAtIndex);
    
}


//=================================================================
//                        instance array
//=================================================================
#pragma mark - instance array


+ (instancetype)AvoidCrashArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    //用来标记元素为nil的下标
    NSMutableArray *errorIndexArrM = nil;
    
    for (int index = 0; index < cnt ; index++) {
        
        if (objects[index] == nil) {
            if (errorIndexArrM == nil) {
                errorIndexArrM = [NSMutableArray array];
            }
            [errorIndexArrM addObject:@(index)];
        }
    }
    
    
    //创建数组的数据正常
    if (errorIndexArrM == nil) {
        return [self AvoidCrashArrayWithObjects:objects count:cnt];
    }
    
    //创建的数组数据不正常<有些元素为nil>
    else {

        [self dealWithInstanceArrayErrorMessageWithErrorIndexArr:errorIndexArrM];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSUInteger count = cnt - errorIndexArrM.count;
        id  _Nonnull __unsafe_unretained tempObjects[count];
        
        int delta = 0;
        for (int i = 0; i < count; i++) {
            while (objects[delta + i] == nil) {
                delta ++;
            }
            
            tempObjects[i] = objects[delta + i];
        }
        return [self AvoidCrashArrayWithObjects:tempObjects count:count];
    }
    
}

/**
 *  实例化一个数组错误信息的获取
 *
 *  @param mainCallStackSymbolMsg 函数调用栈的主要信息
 *  @param errorIndexArr          元素中为nil的下标数组
 *
 *  @return 实例化一个数组错误信息
 */

+ (void)dealWithInstanceArrayErrorMessageWithErrorIndexArr:(NSArray *)errorIndexArr {
    
    //函数调用栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[2]];
    
    
    NSString *errorInfo = [NSString stringWithFormat:@"Instance a array error"];
    NSString *errorReason = @"You attempt to instance array with nil object.";
    NSMutableString *errorDetail = [NSMutableString stringWithFormat:@"nil index in array:"];
    for (NSNumber *indexNumber in errorIndexArr) {
        [errorDetail appendFormat:@"(%@)",indexNumber];
    }
    
    NSString *errorPlace = [NSString stringWithFormat:@"Error Place:%@",mainCallStackSymbolMsg];
    NSString *defaultToDo = @"This framework default is to remove nil object and instance a array.";
    
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


@end
