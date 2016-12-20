//
//  Tree.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "Tree.h"
#import <objc/message.h>

const char *identify = "girlfriend";
const char* propertiesKey = "propertiesKey";
@implementation Tree
@synthesize name = _name;
- (NSString *)name
{
    return objc_getAssociatedObject(self, identify);
}

- (void)setName:(NSString *)name
{
    _name = name;
    objc_setAssociatedObject(self, identify, @"jiaojiao", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray *)properties {
    // 如果已经关联了，就依据key取出被关联的对象并返回
    NSArray *pList = objc_getAssociatedObject(self, propertiesKey);
    if (pList != nil) {
        return pList;
    }
    // 如果没有关联，则设置关联对象，并将对象返回
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    
    for (unsigned int i = 0; i < count; ++i) {
        Ivar pty = ivars[i];
        const char *cname = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:cname];
        NSString *key = [name substringFromIndex:1];
        [arrayM addObject:key];
    }
    free(ivars);
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return arrayM.copy;
}








@end
