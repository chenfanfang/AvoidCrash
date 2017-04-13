//
//  NSObject+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSObject+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSObject (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
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

         [AvoidCrash exchangeInstanceMethod:[self class] method1Sel:@selector(forwardingTargetForSelector:) method2Sel:@selector(avoid_forwardingTargetForSelector:)];
    });

}

- (id)avoid_forwardingTargetForSelector:(SEL)aSelector{
    NSString * selStr = NSStringFromSelector(aSelector);
    /**  这里主要是判断方法存在或者方法是系统实现的私有方法  */
    if([self isExistSelector:aSelector inClass:[self class]] || [selStr hasPrefix:@"_"]){
        return [self avoid_forwardingTargetForSelector:aSelector];
    }else{

        Class stubProxy = NSClassFromString(@"stubProxy");
        if(!stubProxy){
            stubProxy = objc_allocateClassPair([NSObject class], "stubProxy", 0);
            objc_registerClassPair(stubProxy);
        }
        class_addMethod(stubProxy, aSelector, [self unrecognizedImplementation:aSelector], [selStr UTF8String]);
        Class StubProxy = [stubProxy class];
        id instance = [[StubProxy alloc]init];
        return instance;
    }
}

- (BOOL)isExistSelector:(SEL)aSelector inClass:(Class)currentClass{
    BOOL isExist = NO;
    unsigned int methodCount = 0;
    Method * methods = class_copyMethodList(currentClass, &methodCount);
    for (int i = 0; i<methodCount;i++ ) {
        Method tmp = methods[i];
        SEL sel = method_getName(tmp);
        NSString * methodName = NSStringFromSelector(sel);
        if([methodName isEqualToString:NSStringFromSelector(aSelector)]){
            isExist = YES;
            break;
        }
    }
    return isExist;
}

- (IMP)unrecognizedImplementation:(SEL)aSelector{
    IMP imp = imp_implementationWithBlock(^(){
        NSLog(@"Function:%@ unrecognizeMethod resolved",NSStringFromSelector(aSelector));
    });
    return imp;
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


@end
