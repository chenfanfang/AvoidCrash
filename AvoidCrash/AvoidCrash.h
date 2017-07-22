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




/**
 *  提示:
 *  【大家完全可以忽略addIgnoreSystemMethod方法和所对应的一堆文字描述，有兴趣者可以
 *    耐心看下。】
 *  这个方法的功能是为了配合  防止"unrecognized selector sent to instance"导致
 *  的崩溃时数据的收集更加准确。
 *  
 *  其实苹果系统内部里面也有部分方法会报 "unrecognized selector sent to instance"的错误
 *  但苹果进行了相应的处理，才没导致crash。
 *
 *  由于runtime的切入拦截，AvoidCrash会先一步知道苹果系统内部哪些方法会报"unrecognized 
 *  selector sent to instance"的错误
 *  但对于苹果系统内部会自动处理的东西我们没有必要对其进行相应的处理，并且我们也不清楚苹果系统内部
 *  具体的处理方法，所以AvoidCrash会将非开发人员导致的"unrecognized selector sent to 
 *  instance"的错误还给苹果处理，尽可能保证原生性不被破坏，并且不会在控制台输出相应的崩溃信息。
 *
 *  目前已知的方法名有:(可到NSObject+AvoidCrash.m 中查看)
 *                  @"_setTextColor:"
 *                  @"_setMagnifierLineColor:",
 *                  @"applicationShouldFocusWithBundle:onCompletion:"
 *
 *
 *  疑问1:是否必须调用下面的方法。
 *  答  :非必须
 *
 *  ===========================================================
 *
 *  疑问2:若不调用下面的方法，是否破坏了原生性，上面描述不是说苹果系统内部会处理属于苹果自身原因导致
 *       "unrecognized selector sent to instance" 的崩溃吗？
 *  答  : 对于原生性，可能是有点侵入，但猜测苹果内部的实现方式也是防止崩溃,AvoidCrash只是将崩溃提前
 *        处理掉了，也不会造成什么影响，无伤大雅。
 *
 *  ===========================================================
 *
 *  疑问3:该如何知道需要添加哪些方法名称呢？
 *       具体有哪些方法名称需要在实际的开发中才能发现，AvoidCrash会在控制台输出对应的信息来提示你
 *
 *  ===========================================================
 *
 *  疑问4:addIgnoreSystemMethod: 需要在什么地方调用呢?
 *       在哪里调用了becomeEffective，就在那里调用即可，可以进行多次调用来添加多个方法，当然也
 *       可以调用 + (void)addIgnoreSystemMethods:(NSArray<NSString *> *)methodNamesArr;
 */
+ (void)addIgnoreSystemMethod:(NSString *)methodName;



+ (void)addIgnoreSystemMethods:(NSArray<NSString *> *)methodNamesArr;






//user can ignore below method <用户可以忽略以下方法>


+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo methodName:(NSString *)methodName;

@end
