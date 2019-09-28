//
//  ViewController.m
//  https://github.com/chenfanfang/AvoidCrash
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "AvoidCrashPerson.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self executeAllTestMethod];
    
    
}


//=================================================================
//                         NSArray_Test
//=================================================================
#pragma mark - NSArray_Test

- (void)NSArray_Test_InstanceArray {
    NSString *nilStr = nil;
    NSArray *array = @[@"chenfanfang", nilStr, @"iOSDeveloper"];
    NSLog(@"%@",array);
}

- (void)NSArray_Test_ObjectAtIndex {
    NSArray *arr = @[@"chenfanfang", @"iOS_Dev"];
    NSObject *object = arr[100];
    NSLog(@"object = %@",object);
}

- (void)NSArray_Test_objectsAtIndexes {
    NSArray *array = @[@"chenfanfang",@"iOS"];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:100];
    [array objectsAtIndexes:indexSet];
    
}

- (void)NSArray_Test_getObjectsRange {
    
    NSArray *array = @[@"1", @"2", @"3"];//__NSArrayI
    
    //NSArray *array = @[@"1"];//__NSSingleObjectArrayI
    
    //NSArray *array = @[];//NSArray
    
    NSRange range = NSMakeRange(0, 11);
    __unsafe_unretained id cArray[range.length];
    
    
    [array getObjects:cArray range:range];
    
}


//=================================================================
//                       NSMutableArray_Test
//=================================================================
#pragma mark - NSMutableArray_Test

- (void)NSMutableArray_Test_ObjectAtIndex {
    NSMutableArray *array = @[@"chenfanfang"].mutableCopy;
    NSObject *object = array[2];
    //NSObject *object = [array objectAtIndex:20];
    NSLog(@"object = %@",object);
}

- (void)NSMutableArray_Test_SetObjectAtIndex {
    NSMutableArray *array = @[@"chenfanfang"].mutableCopy;
    array[3] = @"iOS";
}

- (void)NSMutableArray_Test_RemoveObjectAtIndex {
    NSMutableArray *array = @[@"chenfanfang", @"iOSDeveloper"].mutableCopy;
    [array removeObjectAtIndex:5];
}

- (void)NSMutableArray_Test_InsertObjectAtIndex {
    
    NSMutableArray *array = @[@"chenfanfang"].mutableCopy;
    
    //test1    beyond bounds
    [array insertObject:@"cool" atIndex:5];
    
    
    //test2    insert nil obj
    //[array insertObject:nil atIndex:0];
    
    
    //test3    insert nil obj
    //NSString *nilStr = nil;
    //[array addObject:nilStr]; //其本质是调用insertObject:
}

- (void)NSMutableArray_Test_GetObjectsRange {
    NSMutableArray *array = @[@"chenfanfang", @"iOSDeveloper"].mutableCopy;
    
    NSRange range = NSMakeRange(0, 11);
    __unsafe_unretained id cArray[range.length];
    
    
    [array getObjects:cArray range:range];
}

//=================================================================
//                       NSDictionary_Test
//=================================================================
#pragma mark - NSDictionary_Test

- (void)NSDictionary_Test_InstanceDictionary {
    NSString *nilStr = nil;
    NSDictionary *dict = @{
                           @"name" : @"chenfanfang",
                           @"age" : nilStr
                           };
    NSLog(@"%@",dict);
}

//=================================================================
//                       NSMutableDictionary_Test
//=================================================================
#pragma mark - NSMutableDictionary_Test


- (void)NSMutableDictionary_Test_SetObjectForKey_1 {
    
    NSMutableDictionary *dict = @{
                                   @"name" : @"chenfanfang"
                                   
                                   }.mutableCopy;
    NSString *ageKey = nil;
    dict[ageKey] = @(25);
    NSLog(@"%@",dict);
}

- (void)NSMutableDictionary_Test_SetObjectForKey_2 {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *ageKey = nil;
    [dict setObject:@(25) forKey:ageKey];
    NSLog(@"%@",dict);
}



- (void)NSMutableDictionary_Test_RemoveObjectForKey {
    
    NSMutableDictionary *dict = @{
                                  @"name" : @"chenfanfang",
                                  @"age" : @(25)
                                  
                                  }.mutableCopy;
    NSString *key = nil;
    [dict removeObjectForKey:key];
    
    NSLog(@"%@",dict);
}


//=================================================================
//                       NSString_Test
//=================================================================
#pragma mark - NSString_Test

- (void)NSString_Test_CharacterAtIndex {
    NSString *str = @"chenfanfang";
    
    unichar characteristic = [str characterAtIndex:100];
    NSLog(@"--%c--",characteristic);
}

- (void)NSString_Test_SubstringFromIndex {
    NSString *str = @"chenfanfang";
    
    NSString *subStr = [str substringFromIndex:100];
    NSLog(@"%@",subStr);
}

- (void)NSString_Test_SubstringToIndex {
    NSString *str = @"chenfanfang";
    
    NSString *subStr = [str substringToIndex:100];
    NSLog(@"%@",subStr);
}

- (void)NSString_Test_SubstringWithRange {
    NSString *str = @"chenfanfang";
    
    NSRange range = NSMakeRange(0, 100);
    NSString *subStr = [str substringWithRange:range];
    NSLog(@"%@",subStr);
}

- (void)NSString_Test_StringByReplacingOccurrencesOfString {
    NSString *str = @"chenfanfang";
    
    NSString *nilStr = nil;
    str = [str stringByReplacingOccurrencesOfString:nilStr withString:nilStr];
    NSLog(@"%@",str);
}

- (void)NSString_Test_StringByReplacingOccurrencesOfStringRange {
    NSString *str = @"chenfanfang";
    
    NSRange range = NSMakeRange(0, 1000);
    str = [str stringByReplacingOccurrencesOfString:@"chen" withString:@"" options:NSCaseInsensitiveSearch range:range];
    NSLog(@"%@",str);
}

- (void)NSString_Test_stringByReplacingCharactersInRangeWithString {
    NSString *str = @"chenfanfang";
    
    NSRange range = NSMakeRange(0, 1000);
    str = [str stringByReplacingCharactersInRange:range withString:@"cff"];
    NSLog(@"%@",str);
}

- (void)NSString_Test_stringByAppendingString {
    NSString *str = @"TEST";
    NSString *nilString = nil;
    str = [str stringByAppendingString:nilString];
    NSLog(@"%@",str);
}

//=================================================================
//                       NSMutableString_Test
//=================================================================
#pragma mark - NSMutableString_Test

- (void)NSMutableString_Test_ReplaceCharactersInRange {
    NSMutableString *strM = [NSMutableString stringWithFormat:@"chenfanfang"];
    NSRange range = NSMakeRange(0, 1000);
    [strM replaceCharactersInRange:range withString:@"--"];
}

- (void)NSMutableString_Test_InsertStringAtIndex{
    NSMutableString *strM = [NSMutableString stringWithFormat:@"chenfanfang"];
    [strM insertString:@"cool" atIndex:1000];
}


- (void)NSMutableString_TestDeleteCharactersInRange{
    NSMutableString *strM = [NSMutableString stringWithFormat:@"chenfanfang"];
    NSRange range = NSMakeRange(0, 1000);
    [strM deleteCharactersInRange:range];
}

//=================================================================
//                      NSAttributedString_Test
//=================================================================
#pragma mark - NSAttributedString_Test

- (void)NSAttributedString_Test_InitWithString {
    NSString *str = nil;
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str];
    NSLog(@"%@",attributeStr);
}

- (void)NSAttributedString_Test_InitWithAttributedString {
    NSAttributedString *nilAttributedStr = nil;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithAttributedString:nilAttributedStr];
    NSLog(@"%@",attributedStr);
    
    
}

- (void)NSAttributedString_Test_InitWithStringAttributes {
    NSDictionary *attributes = @{
                           NSForegroundColorAttributeName : [UIColor redColor]
                           };
    NSString *nilStr = nil;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:nilStr attributes:attributes];
    NSLog(@"%@",attributedStr);
}

//=================================================================
//                   NSMutableAttributedString_Test
//=================================================================
#pragma mark - NSMutableAttributedString_Test

- (void)NSMutableAttributedString_Test_InitWithString {
    
    NSString *nilStr = nil;
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:nilStr];
    NSLog(@"%@",attrStrM);
}

- (void)NSMutableAttributedString_Test_InitWithStringAttributes {

    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSString *nilStr = nil;
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:nilStr attributes:attributes];
    NSLog(@"%@",attrStrM);
}

- (void)NSMutableAttributedString_Test_AddAttributeValueRange{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
     NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    NSString *nilAtrrbutedName = nil;
    [attrStrM addAttribute:nilAtrrbutedName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, [attrStrM.string length])];
    
    UIFont *nilFont = nil;
    [attrStrM addAttribute:NSFontAttributeName value:nilFont range:NSMakeRange(0, [attrStrM.string length])];
    
    NSRange outOfRange = NSMakeRange(0, attrStrM.length + 100);
    [attrStrM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:outOfRange];
    
    [attrStrM addAttribute:nilAtrrbutedName value:nilFont range:outOfRange];
}

- (void)NSMutableAttributedString_Test_AddAttributesRange{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSDictionary *nilAttributes = nil;
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    
    [attrStrM addAttributes:nilAttributes range:NSMakeRange(0, [attrStrM.string length])];
    NSRange outOfRange = NSMakeRange(0, attrStrM.length + 100);
    
    [attrStrM addAttributes:attributes range:outOfRange];
    
    [attrStrM addAttributes:nilAttributes range:outOfRange];
}
 
- (void)NSMutableAttributedString_Test_RemoveAttributesRange{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    NSString *nilAttributedName = nil;
    [attrStrM removeAttribute:nilAttributedName range:NSMakeRange(0, attrStrM.length)];
    
    NSRange outOfRange = NSMakeRange(0, attrStrM.length + 100);
    [attrStrM removeAttribute:NSForegroundColorAttributeName range:outOfRange];
    
    [attrStrM removeAttribute:nilAttributedName range:outOfRange];
}

- (void)NSMutableAttributedString_Test_ReplaceCharactersInRangeWithAttributedString{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    NSAttributedString *nilAttributedString = nil;
    [attrStrM replaceCharactersInRange:NSMakeRange(0, attrStrM.length) withAttributedString:nilAttributedString];
    
    NSRange outOfRange = NSMakeRange(0, attrStrM.length);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"ABC" attributes:attributes];
    [attrStrM replaceCharactersInRange:outOfRange withAttributedString:attributedString];
    
    [attrStrM replaceCharactersInRange:outOfRange withAttributedString:nilAttributedString];
}

- (void)NSMutableAttributedString_Test_InsertAttributedStringAtIndex{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    NSAttributedString *nilAttributedString = nil;
    [attrStrM insertAttributedString:nilAttributedString atIndex:0];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"ABC" attributes:attributes];
    NSInteger outIndex = attrStrM.length + 100;
    [attrStrM insertAttributedString:attributedString atIndex:outIndex];
    
    [attrStrM insertAttributedString:nilAttributedString atIndex:outIndex];
}

- (void)NSMutableAttributedString_Test_AppendAttributedString{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    
    NSAttributedString *nilAttributedString = nil;
    [attrStrM appendAttributedString:nilAttributedString];
}

- (void)NSMutableAttributedString_Test_DeleteCharactersInRange{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    NSRange outOfRange = NSMakeRange(0, attrStrM.length);
    
    [attrStrM deleteCharactersInRange:outOfRange];
}

- (void)NSMutableAttributedString_Test_SetAttributedString{
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor redColor]
                                 };
    NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"TEST" attributes:attributes];
    NSAttributedString *nilAttributedString = nil;
    [attrStrM setAttributedString:nilAttributedString];
}


//=================================================================
//                            KVC
//=================================================================
#pragma mark - KVC


- (void)KVC_Test_SetValueForKey {
    //创建一个任意的对象
    UITableView *anyObject = [UITableView new];
    [anyObject setValue:self forKey:@"AvoidCrash"];
    
}

- (void)KVC_Test_SetValueforKeyPath {
    UITableView *anyObject = [UITableView new];
    [anyObject setValue:self forKey:@"AvoidCrash"];
}


- (void)KVC_Test_SetValuesForKeysWithDictionary {
    //创建一个任意的对象
    UITableView *anyObject = [UITableView new];
    NSDictionary *dictionary = @{
                                 @"name" : @"chenfanfang"
                                 };
    
    [anyObject setValuesForKeysWithDictionary:dictionary];
}


//=================================================================
//              unrecognized selector sent to instance
//=================================================================
#pragma mark - unrecognized selector sent to instance
/**
 测试没有selector的crash
 */
- (void)testNoSelectorCrash {
    
    id person1 = @"chenfanfang";
    person1 = [person1 initWithName:@"cff" age:26 height:170 weight:110];
    
}

- (void)testNoSelectorCrash2 {
    id person = [AvoidCrashPerson new];
    [person objectForKey:@"key"];
}

//=================================================================
//                      执行所有test的方法
//=================================================================
#pragma mark - 执行所有test的方法

- (void)executeAllTestMethod {
    [self NSArray_Test_InstanceArray];
    [self NSArray_Test_ObjectAtIndex];
    [self NSArray_Test_objectsAtIndexes];
    [self NSArray_Test_getObjectsRange];
    
    
    [self NSMutableArray_Test_ObjectAtIndex];
    [self NSMutableArray_Test_SetObjectAtIndex];
    [self NSMutableArray_Test_RemoveObjectAtIndex];
    [self NSMutableArray_Test_InsertObjectAtIndex];
    [self NSMutableArray_Test_GetObjectsRange];
    
    
    [self NSDictionary_Test_InstanceDictionary];
    [self NSMutableDictionary_Test_SetObjectForKey_1];
    [self NSMutableDictionary_Test_SetObjectForKey_2];
    [self NSMutableDictionary_Test_RemoveObjectForKey];
    
    
    [self NSString_Test_CharacterAtIndex];
    [self NSString_Test_SubstringFromIndex];
    [self NSString_Test_SubstringToIndex];
    [self NSString_Test_SubstringWithRange];
    [self NSString_Test_StringByReplacingOccurrencesOfString];
    [self NSString_Test_StringByReplacingOccurrencesOfStringRange];
    [self NSString_Test_stringByReplacingCharactersInRangeWithString];
    [self NSString_Test_stringByAppendingString];
    
    [self NSMutableString_Test_ReplaceCharactersInRange];
    [self NSMutableString_Test_InsertStringAtIndex];
    [self NSMutableString_TestDeleteCharactersInRange];
    
    
    [self NSAttributedString_Test_InitWithString];
    [self NSAttributedString_Test_InitWithAttributedString];
    [self NSAttributedString_Test_InitWithStringAttributes];
    
    
    [self NSMutableAttributedString_Test_InitWithString];
    [self NSMutableAttributedString_Test_InitWithStringAttributes];
    [self NSMutableAttributedString_Test_AddAttributeValueRange];
    [self NSMutableAttributedString_Test_AddAttributesRange];
    [self NSMutableAttributedString_Test_RemoveAttributesRange];
    [self NSMutableAttributedString_Test_ReplaceCharactersInRangeWithAttributedString];
    [self NSMutableAttributedString_Test_InsertAttributedStringAtIndex];
    [self NSMutableAttributedString_Test_AppendAttributedString];
    [self NSMutableAttributedString_Test_DeleteCharactersInRange];
    [self NSMutableAttributedString_Test_SetAttributedString];
    
    
    [self KVC_Test_SetValueForKey];
    [self KVC_Test_SetValueforKeyPath];
    [self KVC_Test_SetValuesForKeysWithDictionary];
    
    
    [self testNoSelectorCrash];
    [self testNoSelectorCrash2];
}




@end
















