//
//  GWCourse.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "GWBaseObject.h"

@interface GWBook : GWBaseObject
@property (copy, nonatomic) NSString *publisher; //出版社
@property (strong, nonatomic) NSDate *publishedTime; //出版时间
@property (assign, nonatomic) double price; //价格
@property (copy, nonatomic) NSString *image; //封面
@property (strong, nonatomic) NSURL *url; //链接
@end
