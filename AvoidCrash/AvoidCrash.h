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

//notification userInfo key (value is NSString)
#define AvoidCrash_Key_ErrorMainMessage @"AvoidCrash_Key_ErrorMainMessage"

//notification userInfo key (value is NSArray)
#define AvoidCrash_Key_CallStackSymbolsArr @"AvoidCrash_Key_CallStackSymbolsArr"


//user can ignore below define
#define AvoidCrashSeparator    @"================================================================"
#define AvoidCrashEnglishTitle @"---------------------------English------------------------------"
#define AvoidCrashChineseTitle @"----------------------------中文---------------------------------"

@interface AvoidCrash : NSObject

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr;

@end
