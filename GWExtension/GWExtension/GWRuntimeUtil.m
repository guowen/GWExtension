//
//  GWRuntimeUtil.m
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/9.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import <objc/runtime.h>
#import "GWRuntimeUtil.h"


static const char *property_getTypeName(objc_property_t property) {
	const char *attributes = property_getAttributes(property);
	char buffer[1 + strlen(attributes)];
	strcpy(buffer, attributes);
	char *state = buffer, *attribute;
	while ((attribute = strsep(&state, ",")) != NULL) {
		if (attribute[0] == 'T') {
			size_t len = strlen(attribute);
			attribute[len - 1] = '\0';
			return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
		}
	}
	return "@";
}

@implementation GWRuntimeUtil

static NSMutableDictionary *propertyListByClass;
static NSMutableDictionary *propertyClassByClassAndPropertyName;

+ (NSArray *)propertyNames:(Class)cls {
  if (!propertyListByClass) {
    propertyListByClass = [[NSMutableDictionary alloc] init];
  }
  NSString *className = NSStringFromClass(cls);
  NSArray *value = [propertyListByClass objectForKey:className];
  
  if (value) {
    return value;
  }
  
  NSMutableArray *propertyNamesArray = [NSMutableArray array];
  unsigned int propertyCount = 0;
  objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
  
  for (unsigned int i = 0; i < propertyCount; ++i) {
    objc_property_t property = properties[i];
    const char * name = property_getName(property);
    
    [propertyNamesArray addObject:[NSString stringWithUTF8String:name]];
  }
  free(properties);
  
  [propertyListByClass setObject:propertyNamesArray forKey:className];
  if (![NSStringFromClass(class_getSuperclass(cls)) isEqualToString:NSStringFromClass([NSObject class])]) {
    NSArray *arr = [GWRuntimeUtil propertyNames:class_getSuperclass(cls)];
    [propertyNamesArray addObjectsFromArray:arr];
  }
  return propertyNamesArray;
}

+ (Class)classWithPropertyName:(NSString *)propertyName
                           cls:(Class)cls {
  if (!propertyClassByClassAndPropertyName) {
    propertyClassByClassAndPropertyName = [[NSMutableDictionary alloc] init];
  }
  
  NSString *key = [NSString stringWithFormat:@"%@:%@", NSStringFromClass(cls), propertyName];
  NSString *value = [propertyClassByClassAndPropertyName objectForKey:key];
  
  if (value) {
    return NSClassFromString(value);
  }
  
  unsigned int propertyCount = 0;
  objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
  
  const char * cPropertyName = [propertyName UTF8String];
  
  for (unsigned int i = 0; i < propertyCount; ++i) {
    objc_property_t property = properties[i];
    const char * name = property_getName(property);
    if (strcmp(cPropertyName, name) == 0) {
      free(properties);
      NSString *className = [NSString stringWithUTF8String:property_getTypeName(property)];
      [propertyClassByClassAndPropertyName setObject:className forKey:key];
      //we found the property - we need to free
      return NSClassFromString(className);
    }
  }
  free(properties);
  //this will support traversing the inheritance chain
  return [self classWithPropertyName:propertyName cls:class_getSuperclass(cls)];
}

@end
