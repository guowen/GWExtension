//
//  GWStudent.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "GWStudent.h"
#import "GWBook.h"

@implementation GWStudent
+ (NSDictionary *)arrayElementsClass {
  return @{
           @"books" : NSStringFromClass([GWBook class])
           };
}
@end
