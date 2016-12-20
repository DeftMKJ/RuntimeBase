//
//  ViewController.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/19.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "FViewController.h"
#import "SViewController.h"
#import "TViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
@interface ViewController ()

@end

// http://www.cnblogs.com/Mike-zh/p/4557014.html#anchor3_2
// http://www.tuccuay.com
// typeEncoding  https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *names = @[@"基本对象创建转化成runtime",@"方法交换实现",@"动态添加方法实现",@"消息转发实现",@"类/对象的关联",@"应用之kvc转模型",@"应用之NSCoding归档与解档"];
    CGFloat height = floor(([UIScreen mainScreen].bounds.size.height - 64) / 7);
    for (NSInteger i = 0; i < 7; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:names[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:random() % 255 / 255.0 green:random() % 255 / 255.0 blue:random() % 255 / 255.0 alpha:1]];
        button.tag = 1000+i;
        button.frame = CGRectMake(0, 64 + i * height, [UIScreen mainScreen].bounds.size.width, height);
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)touchButton:(UIButton *)button
{
    switch (button.tag - 1000) {
        case 0:
        {
            FViewController *fv = [[FViewController alloc] init];
            [self.navigationController pushViewController:fv animated:YES];
        }
            break;
        case 1:
        {
            SViewController *sv = [[SViewController alloc] init];
            [self.navigationController pushViewController:sv animated:YES];
        }
            break;
        case 2:
        {
            TViewController *tv = [[TViewController alloc] init];
            [self.navigationController pushViewController:tv animated:YES];
        }
            break;
        case 3:
        {
            FourViewController *fourv = [[FourViewController alloc] init];
            [self.navigationController pushViewController:fourv animated:YES];
        }
            break;
        case 4:
        {
            FiveViewController *fiveV = [[FiveViewController alloc] init];
            [self.navigationController pushViewController:fiveV animated:YES];
        }
            break;
        case 5:
        {
            SixViewController *sixV = [[SixViewController alloc] init];
            [self.navigationController pushViewController:sixV animated:YES];
        }
            break;
        case 6:
        {
            SevenViewController *sevenV = [[SevenViewController alloc] init];
            [self.navigationController pushViewController:sevenV animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    unsigned int count = 0;
//    Class *class = objc_copyClassList(&count);
//    for (NSInteger i = 0; i < count; i ++) {
//        const char *className = class_getName(class[i]);
//        NSLog(@"%s",className);
//    }
    SevenViewController *fv = [[SevenViewController alloc] init];
    [self.navigationController pushViewController:fv animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
