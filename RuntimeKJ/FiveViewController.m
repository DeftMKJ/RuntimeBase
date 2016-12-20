//
//  FiveViewController.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "FiveViewController.h"
#import <objc/message.h>
#import "Tree.h"
#import "Tree+SubName.h"

@interface FiveViewController ()

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    Tree *tree = [[Tree alloc] init];
    tree.name = @"树";
    tree.age = 10;
    tree.height = 20.05;
    tree.subName = @"fdfdf";
    
    NSLog(@"name = %@,age = %ld,height = %f,关联出来的属性subName = %@",tree.name,tree.age,tree.height,tree.subName);
    
    
    NSLog(@"%@",[Tree properties]);
}




- (IBAction)showAll:(id)sender {
    // 获取成员变量信息
    unsigned count = 0;
    Ivar *ivarLists = class_copyIvarList(objc_getClass("Tree"), &count);
    for (NSInteger i = 0; i < count; i ++)
    {
        const char *name = ivar_getName(ivarLists[i]);
        NSString *str = [NSString stringWithUTF8String:name];
        NSLog(@"111%@",str);
    }
    
    // 获取属性
    objc_property_t *property = class_copyPropertyList(objc_getClass("Tree"), &count);
    for (NSInteger i = 0; i < count; i++)
    {
        const char *name = property_getName(property[i]);
        NSString *str  = [NSString stringWithUTF8String:name];
        NSLog(@"222%@",str);
    }
    
    // 获取方法
    Method *methods = class_copyMethodList(objc_getClass("Tree"), &count);
    for (NSInteger i = 0; i < count; i++) {
        Method method = methods[i];
        NSLog(@"333%@",NSStringFromSelector(method_getName(method)));
    }
    
    // 获取协议
    __unsafe_unretained Protocol **protocol = class_copyProtocolList([self class], &count);
    for (NSInteger i = 0; i < count; i ++) {
        Protocol *pro = protocol[i];
        const char *nameP = protocol_getName(pro);
        NSLog(@"444%@",[NSString stringWithUTF8String:nameP]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
