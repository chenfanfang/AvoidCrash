//
//  AvoidCrash.h
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//category
#import "NSObject+AvoidCrash.h"

#import "NSArray+AvoidCrash.h"
#import "NSMutableArray+AvoidCrash.h"

#import "NSDictionary+AvoidCrash.h"
#import "NSMutableDictionary+AvoidCrash.h"

#import "NSString+AvoidCrash.h"
#import "NSMutableString+AvoidCrash.h"

#import "NSAttributedString+AvoidCrash.h"
#import "NSMutableAttributedString+AvoidCrash.h"


/**
 *  if you want to get the reason that can cause crash, you can add observer notification in AppDelegate.
 *  for example: 
 *
 *  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
 *  
 *  ===========================================================================
 *  
 *  你如果想要得到导致崩溃的原因，你可以在AppDelegate中监听通知，代码如上。
 *  不管你在哪个线程导致的crash,监听通知的方法都会在主线程中
 *
 */
#define AvoidCrashNotification @"AvoidCrashNotification"



//user can ignore below define
#define AvoidCrashDefaultReturnNil  @"This framework default is to return nil to avoid crash."
#define AvoidCrashDefaultIgnore     @"This framework default is to ignore this operation to avoid crash."


#ifdef DEBUG

#define  AvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define AvoidCrashLog(...)
#endif


@interface AvoidCrash : NSObject


/**
 *  become effective . You can call becomeEffective method in AppDelegate didFinishLaunchingWithOptions
 *  
 *  开始生效.你可以在AppDelegate的didFinishLaunchingWithOptions方法中调用becomeEffective方法
 *
 *  这是全局生效，若你只需要部分生效，你可以单个进行处理，比如:
 *  [NSArray avoidCrashExchangeMethod];
 *  [NSMutableArray avoidCrashExchangeMethod];
 *  .................
 *  .................
 */
+ (void)becomeEffective;


//user can ignore below method <用户可以忽略以下方法>


+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;


@end
