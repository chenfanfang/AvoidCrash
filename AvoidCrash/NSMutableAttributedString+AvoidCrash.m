//
//  NSMutableAttributedString+AvoidCrash.m
//  https://github.com/chenfanfang/AvoidCrash
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableAttributedString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableAttributedString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        //initWithString:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:) method2Sel:@selector(avoidCrashInitWithString:)];
        
        //initWithString:attributes:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(initWithString:attributes:) method2Sel:@selector(avoidCrashInitWithString:attributes:)];
        
        //addAttribute:value:range:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(addAttribute:value:range:) method2Sel:@selector(avoidCrashAddAttribute:value:range:)];
        
        //addAttributes:range:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(addAttributes:range:) method2Sel:@selector(avoidCrashAddAttributes:range:)];
        
        //removeAttribute:range:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(removeAttribute:range:) method2Sel:@selector(avoidCrashRemoveAttributes:range:)];
        
        //replaceCharactersInRange:withString:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(replaceCharactersInRange:withAttributedString:) method2Sel:@selector(avoidCrashReplaceCharactersInRange:withAttributedString:)];
        
        //insertAttributedString:atIndex:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(insertAttributedString:atIndex:) method2Sel:@selector(avoidCrashInsertAttributedString:atIndex:)];
         
         //appendString:
         [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(appendString:) method2Sel:@selector(avoidCrashAppendAttributedString:)];
        
        //setAttributedString:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString method1Sel:@selector(setAttributedString:) method2Sel:@selector(avoidCrashSetAttributedString:)];
        
        
    });
}

//=================================================================
//                          initWithString:
//=================================================================
#pragma mark - initWithString:


- (instancetype)avoidCrashInitWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                     initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:


- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

//=================================================================
//                     addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;
//=================================================================
#pragma mark - addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range
- (void)avoidCrashAddAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range{
    @try {
        [self avoidCrashAddAttribute:name value:value range:range];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                     addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;
//=================================================================
#pragma mark - addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range
- (void)avoidCrashAddAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range{
    @try{
        [self avoidCrashAddAttributes:attrs range:range];
    }
    @catch (NSException *exception){
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                     - (void)avoidCrashRemoveAttributes:(NSAttributedStringKey)name range:(NSRange)range;
//=================================================================
#pragma mark - removeAttributes:(NSAttributedStringKey)name range:(NSRange)range
- (void)avoidCrashRemoveAttributes:(NSAttributedStringKey)name range:(NSRange)range{
    @try {
        [self avoidCrashRemoveAttributes:name range:range];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                     - (void)avoidCrashReplaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString;
//=================================================================
#pragma mark - replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString
- (void)avoidCrashReplaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString{
    @try {
        [self avoidCrashReplaceCharactersInRange:range withAttributedString:attrString];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                     - (void)insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc;
//=================================================================
#pragma mark - insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc
- (void)avoidCrashInsertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc{
    @try {
        [self avoidCrashInsertAttributedString:attrString atIndex:loc];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
    
    }
}


//=================================================================
//                     - (void)appendAttributedString:(NSAttributedString *)attrString;
//=================================================================
#pragma mark - appendAttributedString:(NSAttributedString *)attrString
- (void)avoidCrashAppendAttributedString:(NSAttributedString *)attrString{
    @try {
        [self avoidCrashAppendAttributedString:attrString];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

//=================================================================
//                     - (void)deleteCharactersInRange:(NSRange)range;
//=================================================================
#pragma mark - deleteCharactersInRange:(NSRange)range
- (void)avoidCrashDeleteCharactersInRange:(NSRange)range{
    @try {
        [self avoidCrashDeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                     - (void)setAttributedString:(NSAttributedString *)attrString;
//=================================================================
- (void)avoidCrashSetAttributedString:(NSAttributedString *)attrString{
    @try {
        [self avoidCrashSetAttributedString:attrString];
    }
    @catch (NSException *exception) {
        [AvoidCrash noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}

@end
