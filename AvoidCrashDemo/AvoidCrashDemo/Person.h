//
//  Person.h
//  AvoidCrashDemo
//
//  Created by 陈蕃坊 on 2017/7/22.
//  Copyright © 2017年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>

//==================================================
//   本类的作用是用来测试unrecoganized selector的处理情况
//==================================================
@interface Person : NSObject

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age height:(float)height weight:(float)weight;

@end
