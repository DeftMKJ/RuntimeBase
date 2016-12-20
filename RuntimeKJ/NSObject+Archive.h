//
//  NSObject+Archive.h
//  RuntimeKJ
//
//  Created by MKJING on 2016/12/20.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Archive)

- (NSArray *)ignoredProperty;

- (void)mkj_encodeWithCoder:(NSCoder *)aCoder;
- (void)mkj_initWithCoder:(NSCoder *)aDecoder;

@end
