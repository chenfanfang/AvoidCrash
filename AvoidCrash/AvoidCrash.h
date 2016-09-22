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


#define key_errorInfo        @"errorInfo"
#define key_errorReason      @"errorReason"
#define key_errorDetail      @"errorDetail"
#define key_errorPlace       @"errorPlace"
#define key_defaultToDo      @"defaultToDo"
#define key_callStackSymbols @"callStackSymbols"



//user can ignore below define
#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="
#define AvoidCrashEnglishTitle      @"---------------------------English------------------------------"
#define AvoidCrashChineseTitle      @"----------------------------中文---------------------------------"

@interface AvoidCrash : NSObject

//user can ignore below code
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr;


@end
