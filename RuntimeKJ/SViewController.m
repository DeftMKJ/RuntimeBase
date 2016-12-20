//
//  SViewController.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "SViewController.h"
#import "Dog.h"
#import <objc/message.h>
@interface SViewController ()

@end

@implementation SViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    

    objc_msgSend(objc_getClass("Dog"), sel_registerName("eat:"),@"aaa");
    
    // 打印如下
    // 2016-12-19 17:25:15.699 RuntimeKJ[12219:363270] Dog睡了aaa
    // 2016-12-19 17:25:15.700 RuntimeKJ[12219:363270] Dog大口吃屎
    
    // 先是调用eat的方法，但是由于方法的调换，先调用了sleep方法，在sleep方法里面继续调用sleep，实际上调用的是eat方法，这样就完成的方法调换
    
    
//    交换方法实现的需求场景：自己创建了一个功能性的方法，在项目中多次被引用，当项目的需求发生改变时，要使用另一种功能代替这个功能，要求是不改变旧的项目(也就是不改变原来方法的实现)。
//    可以在类的分类中，再写一个新的方法(是符合新的需求的),然后交换两个方法的实现。这样，在不改变项目的代码，而只是增加了新的代码 的情况下，就完成了项目的改进。
//    交换两个方法的实现一般写在类的load方法里面，因为load方法会在程序运行前加载一次，而initialize方法会在类或者子类在 第一次使用的时候调用，当有分类的时候会调用多次
    
    
    
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
