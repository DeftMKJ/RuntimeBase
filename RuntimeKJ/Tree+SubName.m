//
//  Tree+SubName.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "Tree+SubName.h"
#import <objc/message.h>

@implementation Tree (SubName)

- (void)setSubName:(NSString *)subName
{
    objc_setAssociatedObject(self, "subname", subName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSString *)subName
{
    return objc_getAssociatedObject(self, "subname");
}

@end
