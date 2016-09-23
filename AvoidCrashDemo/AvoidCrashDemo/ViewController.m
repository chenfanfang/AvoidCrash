//
//  ViewController.m
//  AvoidCrashDemo
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *nilStr = nil;
    
    NSMutableDictionary *dic = @{
                                 @"name" : @"cff"
                                 }.mutableCopy;
    
    dic[nilStr] = @"333";
}


@end
