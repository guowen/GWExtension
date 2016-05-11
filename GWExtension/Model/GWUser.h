//
//  GWCourse.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "GWBaseObject.h"

typedef enum {
    SexMale,
    SexFemale
} Sex;

@interface GWUser : GWBaseObject
@property (copy, nonatomic) NSString *icon; //头像
@property (assign, nonatomic) unsigned int age; //年龄
@property (strong, nonatomic) NSNumber *height; //身高
@property (strong, nonatomic) NSDecimalNumber *money; //财富
@property (assign, nonatomic) Sex sex; //性别
@property (assign, nonatomic, getter=isGay) BOOL gay; //同性恋
@end
