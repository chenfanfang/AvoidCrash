//
//  NSMutableString+AvoidCrash.h
//  AvoidCrashDemo
//
//  Created by mac on 16/10/6.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (AvoidCrash)

+ (void)avoidCrashExchangeMethod;

@end


/**
 *  Can avoid crash method
 *
 *  1. 由于NSMutableString是继承于NSString,所以这里和NSString有些同样的方法就不重复写了
 *  2. - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
 *  3. - (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc
 *  4. - (void)deleteCharactersInRange:(NSRange)range
 *
 */



