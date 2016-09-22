//
//  AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "AvoidCrash.h"


@implementation AvoidCrash

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr {
    //mainCallStackSymbolMsg的格式为   +[ViewController touchesBegan:withEvent:]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regularExp enumerateMatchesInString:callStackSymbolStr options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbolStr substringWithRange:result.range];
            *stop = YES;
        }
    }];
    return mainCallStackSymbolMsg;
}

@end
