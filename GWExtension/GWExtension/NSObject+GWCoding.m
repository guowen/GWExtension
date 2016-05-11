//
//  NSObject+GWCoding.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/10.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "NSObject+GWCoding.h"
#import "GWRuntimeUtil.h"

@implementation NSObject (GWCoding)

- (void)encode:(NSCoder *)encoder {
  for (NSString *key in [GWRuntimeUtil propertyNames:[self class]]) {
    [encoder encodeObject:[self valueForKey:key] forKey:key];
  }
}

- (void)decode:(NSCoder *)decoder {
  for (NSString *key in [GWRuntimeUtil propertyNames:[self class]]) {
    id value = [decoder decodeObjectForKey:key];
    if (value != [NSNull null] && value != nil) {
      [self setValue:value forKey:key];
    }
  }
}

@end
