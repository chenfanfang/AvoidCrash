//
//  AvoidCrash.h
//  https://github.com/chenfanfang/AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

//===================================================
//   使用方法和注意事项:
//   https://www.jianshu.com/p/2b90aa96c0a0
//===================================================

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

//define
#import "AvoidCrashStubProxy.h"





@interface AvoidCrash : NSObject

//===================================================
//   使用方法和注意事项:
//   https://www.jianshu.com/p/2b90aa96c0a0
//===================================================



/**
 *  
 *  开始生效.你可以在AppDelegate的didFinishLaunchingWithOptions方法中调用becomeEffective方法
 *  【默认不开启  对”unrecognized selector sent to instance”防止崩溃的处理】
 *
 *  这是全局生效，若你只需要部分生效，你可以单个进行处理，比如:
 *  [NSArray avoidCrashExchangeMethod];
 *  [NSMutableArray avoidCrashExchangeMethod];
 *  .................
 *  .................
 *
 */
+ (void)becomeEffective;


/** 
 *  相比于becomeEffective，增加
 *  对”unrecognized selector sent to instance”防止崩溃的处理
 *
 *  但是必须配合:
 *            setupClassStringsArr:和
 *            setupNoneSelClassStringPrefixsArr
 *            这两个方法可以同时使用
 */
+ (void)makeAllEffective;



/** 
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名数组
 *  ⚠️不可将@"NSObject"加入classStrings数组中
 *  ⚠️不可将UI前缀的字符串加入classStrings数组中
 */
+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;


/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 *  ⚠️不可将UI前缀的字符串(包括@"UI")加入classStringPrefixs数组中
 *  ⚠️不可将NS前缀的字符串(包括@"NS")加入classStringPrefixs数组中
 */
+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;

















//您可以忽略以下方法

+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;


@end
