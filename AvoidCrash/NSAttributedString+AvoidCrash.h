//
//  NSAttributedString+AvoidCrash.h
//  AvoidCrashDemo
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (AvoidCrash)

+ (void)avoidCrashExchangeMethod;

@end

/**
 *  Can avoid crash method
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr
 *  3.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 *
 *
 */