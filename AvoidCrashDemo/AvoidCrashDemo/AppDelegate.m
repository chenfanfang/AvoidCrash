//
//  AppDelegate.m
//  AvoidCrashDemo
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "AppDelegate.h"

#import "AvoidCrash.h"
#import "NSArray+AvoidCrash.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //启动防止崩溃功能(注意区分becomeEffective和makeAllEffective的区别)
    //建议在初始化完第三方SDK之后再启动防止崩溃功能
    //[AvoidCrash becomeEffective];
    
    
    [AvoidCrash makeAllEffective];
    
    
    /*
    //假设你不想捕获 [_UITraitBasedAppearance _setMagnifierLineColor:]:unrecognized selector sent to instance
    
    //方法1
    [AvoidCrash addIgnoreClassNamePrefix:@"_UITraitBasedAppearance"];
    //也可以写成前缀模式,或自动忽略所有此前缀类名的类的方法的捕获
    //[AvoidCrash addIgnoreClassNamePrefix:@"_UI"];
    
    
    //方法2
    [AvoidCrash addIgnoreClassNameSuffix:@"_UITraitBasedAppearance"];
    //也可以写成后缀模式,或自动忽略所有此后缀类名的类的方法的捕获
    //[AvoidCrash addIgnoreClassNameSuffix:@"Appearance"];
    
    //方法3
    //[AvoidCrash addIgnoreMethod:@"_setMagnifierLineColor:"];
    */
    
    
    
    
    
    
    
   /*
    *  [AvoidCrash becomeEffective]，是全局生效。若你只需要部分生效，你可以单个进行处理，比如:
    *  [NSArray avoidCrashExchangeMethod];
    *  [NSMutableArray avoidCrashExchangeMethod];
    *  .................
    *  .................
    */
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    return YES;
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //不论在哪个线程中导致的crash，这里都是在主线程
    
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"\n\n在AppDelegate中 方法:dealwithCrashMessage打印\n\n\n\n\n%@\n\n\n\n",note.userInfo);
}


@end
