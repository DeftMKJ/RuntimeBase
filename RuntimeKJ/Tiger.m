//
//  Tiger.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "Tiger.h"
#import <objc/message.h>

@implementation Tiger

//void touch (id self,SEL imp)
//{
//    
//}
#pragma mark - 对象方法
// 没有实现firstMethod的方法

// 1. 在没有找到方法时，会先调用此方法，和DynicmicInsatance的方法一样就可以动态添加方法3
//    返回YES 表示响应的Selector的实现已经被找到并添加到子类中了
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
//    if (sel == @selector(touch)) {
//        class_addMethod([self class], sel, (IMP)touch, "v@:");
//    }
    return YES;
}


// 2.第二步
//   第一步里面返回之后没有添加新方法，该方法就会被调用，在这个方法中，我们可以指定一个可以返回一个响应方法的独享
//   不能返回Self 死循环
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

// 3.第三步
//   如果上面返回了nil则该方法会被调用，给系统一个需要的编码
//   如果这里放回的是nil，那是无法执行下一波的，下次无法得到处理
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 4.第四步
// 调用转发消息方法
- (void)second
{
    NSLog(@"对象方法first方法未被调用，消息转发成了second方法");
}

// 该方法不进行重写就直接进入第五步
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setSelector:@selector(second)];
    [anInvocation invokeWithTarget:self];
}

// 5.第五步
// 如果没有调用第四步的转发，那么会进入异常
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    
    NSLog(@"无法处理的消息:%@",NSStringFromSelector(aSelector));
}

#pragma mark - 类方法
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return YES;
}

+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

+ (void)second
{
    NSLog(@"类方法first没有被调用，消息抓发成了second");
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setSelector:@selector(second)];
    [anInvocation invokeWithTarget:self];
}

+ (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"类无法处理消息：%@", NSStringFromSelector(aSelector));
}



@end
