//
//  NSObject+Archive.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "NSObject+Archive.h"
#import <objc/message.h>

@implementation NSObject (Archive)

- (NSArray *)ignoredProperty
{
    return @[];
}

- (void)mkj_encodeWithCoder:(NSCoder *)aCoder
{
    Class selfClass = self.class;
    while (selfClass && selfClass != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(selfClass, &count);
        for (NSInteger i = 0; i < count; i ++)
        {
            Ivar ivar = ivars[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *ivarStr = [[NSString stringWithUTF8String:ivarName] substringFromIndex:1];
            if ([self respondsToSelector:@selector(ignoredProperty)]) {
                // 如果归档key为空
                if ([[self ignoredProperty] containsObject:ivarStr]) {
                    continue;
                }
            }
            id value = [self valueForKey:ivarStr];
            [aCoder encodeObject:value forKey:ivarStr];
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
}

- (void)mkj_initWithCoder:(NSCoder *)aDecoder
{
    Class selfClass = self.class;
    while (selfClass && selfClass != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(selfClass, &count);
        for (NSInteger i = 0; i < count; i ++)
        {
            Ivar ivar = ivars[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *ivarStr = [[NSString stringWithUTF8String:ivarName] substringFromIndex:1];
            if ([self respondsToSelector:@selector(ignoredProperty)]) {
                // 如果归档key为空
                if ([[self ignoredProperty] containsObject:ivarStr]) {
                    continue;
                }
            }
            id value = [aDecoder decodeObjectForKey:ivarStr];
            [self setValue:value forKey:ivarStr];
            
        }
        free(ivars);
        selfClass = [selfClass superclass];
    }
    
}

@end
