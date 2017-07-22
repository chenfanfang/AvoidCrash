//
//  StubClass.m
//  AvoidCrashDemo
//
//  Created by 翟现旗 on 2016/12/19.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "AvoidCrashStubProxy.h"
#import <objc/runtime.h>

void dynamicMethodIMP(id self, SEL _cmd)
{
    // implementation ....
}

@implementation AvoidCrashStubProxy



+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    //NSLog(@"sel is %@", NSStringFromSelector(sel));
    class_addMethod([self class],sel,(IMP)dynamicMethodIMP,"v@:");
    
    return [super resolveInstanceMethod:sel];
}

@end
