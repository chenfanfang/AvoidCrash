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

    NSMutableArray *array = @[@"cff", @"333"].mutableCopy;
    
    [array removeObjectAtIndex:4];
    
    
}


@end
