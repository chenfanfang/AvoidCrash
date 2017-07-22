//
//  NSObject+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSObject+AvoidCrash.h"
#import "AvoidCrash.h"
#import "AvoidCrashStubProxy.h"

@implementation NSObject (AvoidCrash)


+ (void)addIgnoreMethod:(NSString *)methodName {
    
    [NSObject setupIgnoreMethodNameArrM];
    if ([ignoreMethodNameArrM containsObject:methodName] == NO) {
        [ignoreMethodNameArrM addObject:methodName];
    }
}

+ (void)addIgnoreClassNamePrefix:(NSString *)classNamePrefix {
    [NSObject setupIgnoreClassNamePrefixArrM];
    if ([ignoreClassNamePrefixArrM containsObject:classNamePrefix] == NO) {
        [ignoreClassNamePrefixArrM addObject:classNamePrefix];
    }
}


+ (void)avoidCrashExchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //setValue:forKey:
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKey:) method2Sel:@selector(avoidCrashSetValue:forKey:)];
        
        //setValue:forKeyPath:
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKeyPath:) method2Sel:@selector(avoidCrashSetValue:forKeyPath:)];
        
        //setValue:forUndefinedKey:
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forUndefinedKey:) method2Sel:@selector(avoidCrashSetValue:forUndefinedKey:)];
        
        //setValuesForKeysWithDictionary:
        [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(setValuesForKeysWithDictionary:) method2Sel:@selector(avoidCrashSetValuesForKeysWithDictionary:)];
        
        //forwardingTargetForSelector
        if (ifDealWithNoneSel) {
            [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(forwardingTargetForSelector:) method2Sel:@selector(avoidCrashForwardingTargetForSelector:)];
        }
        
    });
    
    
}


//=================================================================
//                         setValue:forKey:
//=================================================================
#pragma mark - setValue:forKey:

- (void)avoidCrashSetValue:(id)value forKey:(NSString *)key {
    @try {
        [self avoidCrashSetValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                     setValue:forKeyPath:
//=================================================================
#pragma mark - setValue:forKeyPath:

- (void)avoidCrashSetValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self avoidCrashSetValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}



//=================================================================
//                     setValue:forUndefinedKey:
//=================================================================
#pragma mark - setValue:forUndefinedKey:

- (void)avoidCrashSetValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self avoidCrashSetValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//                  setValuesForKeysWithDictionary:
//=================================================================
#pragma mark - setValuesForKeysWithDictionary:

- (void)avoidCrashSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self avoidCrashSetValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}


//=================================================================
//            forwardingTargetForSelector
//=================================================================
#pragma mark - forwardingTargetForSelector

static NSMutableArray *ignoreMethodNameArrM = nil;
static NSMutableArray *ignoreClassNamePrefixArrM = nil;



- (id)avoidCrashForwardingTargetForSelector:(SEL)aSelector {
    id proxy = [self avoidCrashForwardingTargetForSelector:aSelector];
    
    if (!proxy) {
        [NSObject setupIgnoreClassNamePrefixArrM];
        
        BOOL isIgnore = NO;
        NSString *methodName = NSStringFromSelector(aSelector);
        NSString *className = NSStringFromClass([self class]);
        for (NSString *prefix in ignoreClassNamePrefixArrM) {
            if ([className hasPrefix:prefix]) {
                isIgnore = YES;
                break;
            }
        }
        
        if (!isIgnore) {
            
            proxy = [[AvoidCrashStubProxy alloc] init];
            NSString *name = @"unrecognized selector sent to instance";
            NSString *reason = [NSString stringWithFormat:@"[%@ %@]:unrecognized selector sent to instance",NSStringFromClass([self class]), methodName];
            NSException *exception = [NSException exceptionWithName:name reason:reason userInfo:nil];
            NSString *defaultToDo = @"use stub proxy to avoid crash";
            [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo methodName:methodName className:className];
        }
    }
    return proxy;
}



+ (void)setupIgnoreMethodNameArrM {
    if (!ignoreMethodNameArrM) {
        ignoreMethodNameArrM = [NSMutableArray array];
    }
    
}

+ (void)setupIgnoreClassNamePrefixArrM {
    if (!ignoreClassNamePrefixArrM) {
        ignoreClassNamePrefixArrM = @[
                                        @"_NS",
                                        @"_UI"
                                        ].mutableCopy;
    }
}


@end
