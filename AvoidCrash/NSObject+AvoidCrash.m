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

+ (void)addIgnoreClassNameSuffix:(NSString *)classNameSuffix {
    [NSObject setupIgnoreClassNameSuffixArrM];
    if ([ignoreClassNameSuffixArrM containsObject:classNameSuffix] == NO) {
        [ignoreClassNameSuffixArrM addObject:classNameSuffix];
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
static NSMutableArray *ignoreClassNameSuffixArrM = nil;


- (id)avoidCrashForwardingTargetForSelector:(SEL)aSelector {
    id proxy = [self avoidCrashForwardingTargetForSelector:aSelector];
    
    if (!proxy) {
        [NSObject setupIgnoreClassNamePrefixArrM];
        
        NSString *methodName = NSStringFromSelector(aSelector);
        NSString *className = NSStringFromClass([self class]);
        
        
        BOOL isIgnore = [NSObject isIgnoreWithClassName:className method:methodName];
        
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


+ (BOOL)isIgnoreWithClassName:(NSString *)className method:(NSString *)methodName {
    __block BOOL isIgnore = NO;
    
    NSString *classNamePrefix2 = nil;
    if (className.length >= 2) {
        classNamePrefix2 = [className substringToIndex:2];
        NSString *regularExpStr = @"_[A-Z]";
        NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
        
        [regularExp enumerateMatchesInString:classNamePrefix2 options:NSMatchingReportProgress range:NSMakeRange(0, classNamePrefix2.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            if (result) {
                isIgnore = YES;
            }
            *stop = YES;
        }];
    }
    
    if (isIgnore) {
        return isIgnore;
    }
    
    for (NSString *prefix in ignoreClassNamePrefixArrM) {
        if ([className hasPrefix:prefix]) {
            return YES;
        }
    }
    
    for (NSString *suffix in ignoreClassNameSuffixArrM) {
        if ([className hasSuffix:suffix]) {
            return YES;
        }
    }
    
    for (NSString *method in ignoreMethodNameArrM) {
        if ([method isEqualToString:methodName]) {
            return YES;
        }
    }
    return isIgnore;
}


+ (void)setupIgnoreMethodNameArrM {
    if (!ignoreMethodNameArrM) {
        ignoreMethodNameArrM = [NSMutableArray array];
    }
    
}

+ (void)setupIgnoreClassNamePrefixArrM {
    if (!ignoreClassNamePrefixArrM) {
        ignoreClassNamePrefixArrM = @[@"UI"].mutableCopy;
    }
}

+ (void)setupIgnoreClassNameSuffixArrM {
    if (!ignoreClassNameSuffixArrM) {
        ignoreClassNameSuffixArrM = [NSMutableArray array];
    }
}


@end
