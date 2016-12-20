//
//  Dog.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "Dog.h"
#import <objc/message.h>

@implementation Dog

// Load的时候如果下面的方法是-方法，那么是无效的，类方法对实例方法无法操作
+ (void)load
{
    Method eatM = class_getClassMethod(self, sel_registerName("eat:"));
    
    Method sleepM = class_getClassMethod(self, @selector(sleep:));
    
    method_exchangeImplementations(eatM, sleepM);
}

// 如果要在自己的方法里面调用另个一个方法，直接调用自己的方法名就好了
+ (void)eat:(NSString *)food
{
    
    NSLog(@"%@大口吃%@",NSStringFromClass([self class]),food);
}

// 如果这样调用直接死循环了
+ (void)sleep:(NSString *)name
{
//    [self eat:@"屎"]; 死循环
    
    NSLog(@"%@睡了%@",NSStringFromClass([self class]),name);
    
    [self sleep:@"屎"];
}

@end
