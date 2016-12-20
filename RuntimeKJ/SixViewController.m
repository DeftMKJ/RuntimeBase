//
//  SixViewController.m
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "SixViewController.h"
#import "MKJModel.h"
#import "NSObject+Model.h"


@interface SixViewController ()

@end

@implementation SixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 1.URL
    NSString *githubAPI = @"https://api.github.com/users/Tuccuay";
    
    // 2.创建请求对象
    // 对象内部已经包含了请求方法和请求头（GET）
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:githubAPI]];
    
    // 3.创建session单例
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象发送请求
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        MKJModel *mkj = [MKJModel configModelWithDict:jsonDict replaceDict:@{@"mkjLogin":@"login",
                                                                             @"mkjID":@"id",
                                                                             @"mkjAvatar_url":@"avatar_url",
                                                                             @"mkjGravatar_id":@"gravatar_id",
                                                                             @"mkjUrl":@"url",
                                                                             @"mkjHtml_url":@"html_url",
                                                                             @"mkjFollowers_url":@"followers_url",
                                                                             @"mkjFollowing_url":@"following_url",
                                                                             @"mkjGists_url":@"gists_url",
                                                                             @"mkjStarred_url":@"starred_url",
                                                                             }];
        NSLog(@"%@",mkj);
        
    }];
    
    // 5.task resume
    [dataTask resume];
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
