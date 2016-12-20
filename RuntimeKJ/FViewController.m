//
//  FViewController.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "FViewController.h"

@interface FViewController ()

@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.view.backgroundColor = [UIColor greenColor];
    /*
     * 以下代码runtime转换如下  clang -rewrite-objc 文件名
     */
//    People *p1 = [[People alloc] init];
//    [p1 eat:@"屎"];
    
    //    People *p1 = ((People *(*)(id, SEL))(void *)objc_msgSend)((id)((People *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("People"), ), sel_registerName("init"));
    
    //    ((void (*)(id, SEL, NSString *))(void *)objc_msgSend)((id)p1, sel_registerName("eat:"), (NSString *)&__NSConstantStringImpl__var_folders_c2_z9kbf6xs7x3g3qc4vwt8b10w0000gn_T_main_c68e89_mi_1);
    
    
    
    // 换这个方式创建下
    // 1.objc_getClass("People") 获取类
    // 2.sel_registerName("alloc") 注册表中拿方法 可以用成@selector
    // 3.objc_msgSend(类名, @selector(), 参数);
    
    // 根据类名获取到类
    Class class = objc_getClass("People");
    // 这里直接写会报错 请将 Build Setting -> Enable Strict Checking of objc_msgSend Calls 改为 NO
    People *people = objc_msgSend(class,@selector(alloc));
    // runtime初始化对象
    people = objc_msgSend(people, @selector(init));
    // 方法调用  这里的类方法不暴露都能调用到  但是这里会出现警告 最终还是能到方法列表里面找到该方法打印
    objc_msgSend(people, @selector(eat:),@"屎");
    
    // 单参数
    People *people2 = objc_msgSend(objc_msgSend(objc_getClass("People"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(people2, sel_registerName("eat:"),@"香蕉");
    
    // 多参数
    People *people3 = objc_msgSend(objc_msgSend(objc_getClass("People"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(people3, sel_registerName("play:age:block:"),@"美女",18,[^{NSLog(@"我来了");} copy]);
    
    // 打印如下
//    2016-12-19 16:45:34.974 RuntimeKJ[11526:324368] People eat 屎
//    2016-12-19 16:45:34.974 RuntimeKJ[11526:324368] People eat 香蕉
//    2016-12-19 16:45:34.975 RuntimeKJ[11526:324368] name = 美女,age = 18,<__NSGlobalBlock__: 0x10ecd90a0>
//    2016-12-19 16:45:34.975 RuntimeKJ[11526:324368] 我来了美女
    
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
