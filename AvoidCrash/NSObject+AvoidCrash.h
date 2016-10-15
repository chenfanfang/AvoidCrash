//
//  NSObject+AvoidCrash.h
//  AvoidCrashDemo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AvoidCrash)

+ (void)avoidCrashExchangeMethod;

@end

/**
 *  Can avoid crash method
 *
 *  1.- (void)setValue:(id)value forKey:(NSString *)key
 *  2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
 *  3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
 *  4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
 *
 */