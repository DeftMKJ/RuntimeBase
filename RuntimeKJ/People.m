//
//  People.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "People.h"

@implementation People

- (void)eat:(NSString *)food
{
    NSLog(@"%@ eat %@",NSStringFromClass([self class]),food);
}


- (void)play:(NSString *)name age:(NSUInteger)age block:(void(^)(void))block
{
    NSLog(@"name = %@,age = %ld,%@",name,age,block);
    block();
}

@end
