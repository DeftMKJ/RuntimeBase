//
//  MKJModel.h
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKJModel : NSObject

/*
 *  这里的字段都是和JSON一一对应的，但是根据需求把前十个改为自定义字段，进行二次映射
 */
@property (nonatomic, strong) NSString *mkjLogin;
@property (nonatomic, assign) NSNumber *mkjID;
@property (nonatomic, strong) NSString *mkjAvatar_url;
@property (nonatomic, strong) NSString *mkjGravatar_id;
@property (nonatomic, strong) NSString *mkjUrl;
@property (nonatomic, strong) NSString *mkjHtml_url;
@property (nonatomic, strong) NSString *mkjFollowers_url;
@property (nonatomic, strong) NSString *mkjFollowing_url;
@property (nonatomic, strong) NSString *mkjGists_url;
@property (nonatomic, strong) NSString *mkjStarred_url;

@property (nonatomic, strong) NSString *subscriptions_url;
@property (nonatomic, strong) NSString *organizations_url;
@property (nonatomic, strong) NSString *repos_url;
@property (nonatomic, strong) NSString *events_url;
@property (nonatomic, strong) NSString *received_events_url;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL site_admin;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *blog;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *email;
@property (nonatomic,assign) BOOL hireable;
@property (nonatomic,assign) long long public_repos;
@property (nonatomic,assign) long long public_gists;
@property (nonatomic,assign) long long followers;
@property (nonatomic,assign) long long following;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *updated_at;

/*
 *  1.首先属性小于数据源的时候是肯定没问题的
 *  2.当属性大于数据源的时候，属性书对象，打印出来就是nil，但是如果属性是基本数据类型，直接崩溃
 *  一定要这么判断是否是基本数据类型
 *  避免属性数量大于数据数量的时候，如果多出来的属性是对象类型的那正好是null,无影响，如果多出来的属性是普通类型的，那会把nil赋值过去，直接崩溃
 *  if ([codingstr isEqualToString:@"f"] || [codingstr isEqualToString:@"d"]) {
 *  value = @(0.0);
 }
 */
@property (nonatomic,copy) NSString *name1;
@property (nonatomic,copy) NSString *name2;
@property (nonatomic,copy) NSString *name3;
@property (nonatomic,copy) NSString *name4;
@property (nonatomic,copy) NSString *name5;
@property (nonatomic,copy) NSString *name6;
@property (nonatomic,assign) double iii;




@end
