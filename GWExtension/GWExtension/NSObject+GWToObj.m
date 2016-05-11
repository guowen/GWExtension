//
//  NSObject+GWToObj.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/9.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "NSObject+GWToObj.h"
#import "GWRuntimeUtil.h"

@implementation NSObject (GWToObj)

+ (instancetype)toObjWithDic:(NSDictionary *)dic {
  return [[[self alloc] init] toObjWithDic:dic];
}

- (id)toObjWithDic:(NSDictionary *)dic {
  for (NSString *key in [GWRuntimeUtil propertyNames:[self class]]) {
    id value = [dic valueForKey:key];
    
    if (value == nil || value == [NSNull null]) {
      continue;
    }
    
    if ([value isKindOfClass:[NSDictionary class]]) {
      [self setValue:[self valueForKey:key dic:value] forKey:key];
    } else if ([value isKindOfClass:[NSArray class]]) {
      [self setValue:[self valueForKey:key array:value] forKey:key];
    } else {
      [self setValue:value forKey:key];
    }
  }
  return self;
}

- (id)valueForKey:(NSString *)key dic:(NSDictionary *)dic {
  Class dc = [GWRuntimeUtil classWithPropertyName:key cls:[self class]];
  return [dc toObjWithDic:dic];
}

- (id)valueForKey:(NSString *)key array:(NSArray *)array {
  NSMutableArray *value = [NSMutableArray arrayWithCapacity:array.count];
  for (id obj in array) {
    if ([[obj class] isSubclassOfClass:[NSDictionary class]]) {
      Class ac = NSClassFromString([[self class] arrayElementsClass][key]);
      [value addObject:[ac toObjWithDic:obj]];
    } else {
      [value addObject:obj];
    }
  }
  return value;
}

@end
