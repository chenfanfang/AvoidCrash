//
//  NSMutableAttributedString+AvoidCrash.h
//  https://github.com/chenfanfang/AvoidCrash
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvoidCrashProtocol.h"

@interface NSMutableAttributedString (AvoidCrash)<AvoidCrashProtocol>


@end


/**
 *  Can avoid crash method
 *
 *  1.- (instancetype)initWithString:(NSString *)str
 *  2.- (instancetype)initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs
 *  3.- (void)addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;
 *  4.- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
 *  5.- (void)removeAttribute:(NSAttributedStringKey)name range:(NSRange)range;
 
 *  6.- (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString;
 *  7.- (void)insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc;
 *  8.- (void)appendAttributedString:(NSAttributedString *)attrString;
 *  9.- (void)deleteCharactersInRange:(NSRange)range;
 *  10.- (void)setAttributedString:(NSAttributedString *)attrString;
 */
