//
//  NSObject+GWToDic.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/10.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "NSObject+GWToDic.h"
#import "GWRuntimeUtil.h"

@implementation NSObject (GWToDic)

- (NSDictionary *)toDic {
  NSMutableDictionary *dic = [NSMutableDictionary dictionary];
  for (NSString *key in [GWRuntimeUtil propertyNames:[self class]]) {
    id value = [self valueForKey:key];
    if ((value && [value isKindOfClass:[NSArray class]] &&
         ((NSArray *)value).count > 0) ||
        (value && [value isKindOfClass:[NSMutableArray class]] &&
         ((NSMutableArray *)value).count > 0) ||
        (value && [value isKindOfClass:[NSSet class]] &&
         ((NSSet *)value).count > 0) ||
        (value && [value isKindOfClass:[NSMutableSet class]] &&
         ((NSMutableSet *)value).count > 0)) {
      [dic setObject:[self valueForArray:value] forKey:key];
    } else if (value && [value isKindOfClass:[NSObject class]]
               && ![NSStringFromClass([value class]) hasPrefix:@"NS"]
               && ![NSStringFromClass([value class]) hasPrefix:@"__NS"]) {
      [dic setObject:[value toDic] forKey:key];
    } else if (value != nil) {
      [dic setObject:value forKey:key];
    }
  }
  return dic;
}

- (id)valueForArray:(NSArray *)array {
  id val = [array objectAtIndex:0];
  if (val && [val isKindOfClass:[NSObject class]]) {
    NSMutableArray *items = [NSMutableArray array];
    for (id val in array) {
      [items addObject:[val toDic]];
    }
    return items;
  } else {
    return array;
  }
}

- (id)toJsonObj {
  if ([self isKindOfClass:[NSString class]]) {
    return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
  } else if ([self isKindOfClass:[NSData class]]) {
    return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
  } else {
    return [self toDic];
  }
}

- (NSData *)toJsonData {
  if ([self isKindOfClass:[NSString class]]) {
    return [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
  } else if ([self isKindOfClass:[NSData class]]) {
    return (NSData *)self;
  }
  return [NSJSONSerialization dataWithJSONObject:[self toJsonObj] options:kNilOptions error:nil];
}

- (NSString *)toJsonStr {
  if ([self isKindOfClass:[NSString class]]) {
    return (NSString *)self;
  } else if ([self isKindOfClass:[NSData class]]) {
    return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
  }
  
  return [[NSString alloc] initWithData:[self toJsonData] encoding:NSUTF8StringEncoding];
}

@end
