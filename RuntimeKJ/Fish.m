//
//  Fish.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "Fish.h"
#import "NSObject+Archive.h"

@implementation Fish

- (NSArray *)ignoredNames
{
    return @[];
}
// 解档的时候调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super init]) {
        [self mkj_initWithCoder:aDecoder];
    }
    return self;
}


// 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self mkj_encodeWithCoder:aCoder];
}

#pragma mark - 普通模式下的归档和解档
//实现NSCoding协议中的归档方法
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.age forKey:@"age"];
//}
//
//
////实现NSCoding协议中的解档方法
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.age = [aDecoder decodeObjectForKey:@"age"];
//    }
//    return self;
//}

@end
