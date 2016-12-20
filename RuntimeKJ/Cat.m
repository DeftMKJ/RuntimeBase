//
//  Cat.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "Cat.h"
#import <objc/runtime.h>

@implementation Cat
// Listing 1
void run (id self, SEL _cmd,NSNumber *meter,NSString *name)
{
    // implementation .....
    NSLog(@"%@跑了%@",name,meter);
}


//对实现(abc)的前两个参数的说明
//每个方法的内部都默认包含两个参数，被称为隐式参数
//id类型self(代表类或对象)和SEL类型的_cmd(方法编号)
//class_addMethod函数参数的含义:
//第一个参数Class cls, 类型
//第二个参数SEL name, 被解析的方法
//第三个参数 IMP imp, 指定的实现
//第四个参数const char *types,方法的类型，具体参照类型的codeType那张图，但是要注意一点：Since the function must take at least two arguments—self and _cmd, the second and third characters must be “@:” (the first character is the return type).译为：因为函数必须至少有两个参数self和_cmd,第二个和第三个字符必须是“@:”。如果想要再增加参数，就可以从实现的第三个参数算起，看下面的例子就明白。
// Listing 2
// 当调用有未实现的方法的时候会进到这里来
+ (BOOL) resolveInstanceMethod:(SEL)aSEL
{
    // 多参数就是"run:"无参数就是run
    if (aSEL == @selector(run:))
    {
        class_addMethod([self class], aSEL, (IMP) run, "v@:@:@");// 增加了2个对象类型参数 增加了@
        return YES;
    }
//    return [super resolveInstanceMethod:aSEL];
    return YES;
}


+ (BOOL)resolveClassMethod:(SEL)sel
{
    NSLog(@"类方法未实现");
    return NO;
}
@end
