//
//  GWCourse.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "GWBaseObject.h"
#import "NSObject+GWCoding.h"

@implementation GWBaseObject
- (id)initWithCoder:(NSCoder *)decoder {
  if (self = [super init]) {
    [self decode:decoder];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [self encode:encoder];
}
@end
