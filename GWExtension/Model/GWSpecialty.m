//
//  GWCourse.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "GWSpecialty.h"
#import "GWStudent.h"

@implementation GWSpecialty
+ (NSDictionary *)arrayElementsClass {
  return @{
           @"students" : NSStringFromClass([GWStudent class])
           };
}

@end
