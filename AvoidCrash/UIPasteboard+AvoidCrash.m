//
//  UIPasteboard+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by Justin.wang on 2019/3/26.
//  Copyright © 2019年 chenfanfang. All rights reserved.
//

#import "UIPasteboard+AvoidCrash.h"
#import "AvoidCrash.h"

@implementation UIPasteboard (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"_UIConcretePasteboard");
        [AvoidCrash exchangeInstanceMethod:cls
                               method1Sel:@selector(setString:)
                               method2Sel:@selector(avoidCrashSetString:)];
    });
}

- (void)avoidCrashSetString:(NSString *)string {
    @try {
       [self avoidCrashSetString:string];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
   
}

@end
