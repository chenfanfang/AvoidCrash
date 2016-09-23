//
//  AvoidCrash.h
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>


#define AvoidCrashNotification @"AvoidCrashNotification"

//user can ignore below define

#define AvoidCrashDefaultReturnNil  @"This framework default is to return nil."
#define AvoidCrashDefaultIgnore     @"This framework default is to ignore this operation to avoid crash."

@interface AvoidCrash : NSObject

//user can ignore below code
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr;

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;


@end
