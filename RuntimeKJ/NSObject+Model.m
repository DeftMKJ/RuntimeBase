//
//  NSObject+Model.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)

+ (instancetype)configModelWithDict:(NSDictionary *)jsonDict replaceDict:(NSDictionary *)replaceDict
{
    id obj = [[self alloc] init];
    unsigned int count = 0;
    // 获取变量列表
    Ivar *ivarLists = class_copyIvarList(self, &count);
    // 遍历逐个进行使用
    for (NSInteger i = 0; i < count; i ++)
    {
        // 获取变量对象
        Ivar ivar = ivarLists[i];
        const char *name = ivar_getName(ivar);
        const char *coding = ivar_getTypeEncoding(ivar); // 判断类型
        // 获取自己写的属性变量字符串 _name
        NSString *nameStr = [[NSString stringWithUTF8String:name] substringFromIndex:1];
        NSString *codingstr = [NSString stringWithUTF8String:coding];
        // 根据字符串在原生字典取值
        id value = jsonDict[nameStr];
        // 如果未取到值  说明字段已经修改了
        if (!value) {
            if (replaceDict) {
                // 然后把修改之前的原生字段拿出来进行取值
                NSString *originValue = replaceDict[nameStr];
                // 再赋值
                value = jsonDict[originValue];
            }
        }
        // 避免属性数量大于数据数量的时候，如果多出来的属性是对象类型的那正好是null,无影响，如果多出来的属性是普通类型的，那会把nil赋值过去，直接崩溃
        if ([codingstr isEqualToString:@"f"] || [codingstr isEqualToString:@"d"]) {
            value = @(0.0);
        }
        // kvc进行模型组装 这里的value类型和property里面给的属性效果是一致的，如果属性是BOOL，你强行给字符串，实际类型还是BOOL
        [obj setValue:value forKey:nameStr];
    }
    return obj;
}

@end
