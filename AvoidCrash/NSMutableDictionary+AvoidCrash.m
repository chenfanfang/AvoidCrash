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

+ (void)avoidCrashExchangeMethod {
    
    Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
    
    
    //setObject:forKey:
    [AvoidCrash exchangeInstanceMethod:dictionaryM method1Sel:@selector(setObject:forKey:) method2Sel:@selector(avoidCrashSetObject:forKey:)];

    
    //removeObjectForKey:
    Method removeObjectForKey = class_getInstanceMethod(dictionaryM, @selector(removeObjectForKey:));
    Method avoidCrashRemoveObjectForKey = class_getInstanceMethod(dictionaryM, @selector(avoidCrashRemoveObjectForKey:));
    method_exchangeImplementations(removeObjectForKey, avoidCrashRemoveObjectForKey);
}


//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - setObject:forKey:

- (void)avoidCrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    @try {
        [self avoidCrashSetObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    
    @try {
        [self avoidCrashRemoveObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}




@end
