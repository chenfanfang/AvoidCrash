//
//  NSMutableAttributedString+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableAttributedString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableAttributedString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
    
    //initWithString:
    [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(avoidCrashInitWithString:)];
    
    //initWithString:attributes:
    [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(avoidCrashInitWithString:attributes:)];
}

//=================================================================
//                          initWithString:
//=================================================================
#pragma mark - initWithString:


- (instancetype)avoidCrashInitWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                     initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:


- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


@end
