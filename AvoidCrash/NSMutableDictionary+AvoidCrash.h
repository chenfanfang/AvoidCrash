//
//  NSMutableDictionary+AvoidCrash.h
//  AvoidCrash
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (AvoidCrash)

+ (void)avoidCrashExchangeMethod;

@end


/**
 *  Can avoid crash method
 *
 *  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
 *  2. - (void)removeObjectForKey:(id)aKey
 *
 */