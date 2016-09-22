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
//    Method arrayWithObjects = class_getClassMethod(self, @selector(arrayWithObjects:count:));
//    Method avoidCrashArrayWithObjects = class_getClassMethod(self, @selector(AvoidCrashArrayWithObjects:count:));
//    method_exchangeImplementations(arrayWithObjects, avoidCrashArrayWithObjects);
    
    
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
    
    NSMutableArray *errorIndexArrM = nil;
    
    for (int index = 0; index < cnt ; index++) {
        
        if (objects[index] == nil) { //说明数组中有nil
            if (errorIndexArrM == nil) {
                errorIndexArrM = [NSMutableArray array];
            }
            [errorIndexArrM addObject:@(index)];
        }
    }
    
    
    //创建数组的数组数据正常
    if (errorIndexArrM == nil) {
        return [self AvoidCrashArrayWithObjects:objects count:cnt];
    }
    
    //创建的数组不正常
    else {

        //错误信息函数调用栈主要信息的获取
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];

        NSString *mainCallStackSymbolMsg = [AvoidCrash getMainCallStackSymbolMessageWithCallStackSymbolStr:callStackSymbolsArr[1]];
        
        NSString *instanceArrayErrorMessage = [self getInstanceArrayErrorMessageWithMainCallStackSymbolMsg:mainCallStackSymbolMsg errorIndexArr:errorIndexArrM];
        NSLog(@"%@",instanceArrayErrorMessage);
        
        NSDictionary *userInfo = @{
                                   AvoidCrash_Key_ErrorMainMessage : instanceArrayErrorMessage,
                                   AvoidCrash_Key_CallStackSymbolsArr : callStackSymbolsArr
                                   };
        [[NSNotificationCenter defaultCenter] postNotificationName:AvoidCrashNotification object:nil userInfo:userInfo];
        
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

+ (NSString *)getInstanceArrayErrorMessageWithMainCallStackSymbolMsg:(NSString *)mainCallStackSymbolMsg errorIndexArr:(NSArray *)errorIndexArr {
    NSMutableString *instanceArrayErrorMessage = [NSMutableString stringWithFormat:@"\n\n%@\n\n%@\nInstance a array error:\nYou attempt to instance array with nil object.\nThis framework default is to remove nil object and instance a array.\nError Place:%@\nnil index in array:",AvoidCrashSeparator,AvoidCrashEnglishTitle,mainCallStackSymbolMsg];
    
    for (NSNumber *indexNumber in errorIndexArr) {
        [instanceArrayErrorMessage appendFormat:@"(%@)",indexNumber];
    }
    
    [instanceArrayErrorMessage appendFormat:@"\n%@\n创建一个数组出错:\n你要创建的数组里面包含nil.\n这个框架默认的做法是移除所有的nil,然后实例化一个数组。\n错误的地方:%@\nnil在数组中的下标:",AvoidCrashChineseTitle, mainCallStackSymbolMsg];
    
    for (NSNumber *indexNumber in errorIndexArr) {
        [instanceArrayErrorMessage appendFormat:@"(%@)",indexNumber];
    }
    
    [instanceArrayErrorMessage appendFormat:@"\n\n%@\n\n",AvoidCrashSeparator];
    
    return instanceArrayErrorMessage;
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






@end
