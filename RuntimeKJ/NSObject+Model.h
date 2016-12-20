//
//  NSObject+Model.h
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (instancetype)configModelWithDict:(NSDictionary *)jsonDict replaceDict:(NSDictionary *)replaceDict;

@end
