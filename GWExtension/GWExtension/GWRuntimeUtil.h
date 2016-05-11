//
//  GWRuntimeUtil.h
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/9.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWRuntimeUtil : NSObject
+ (NSArray *)propertyNames:(Class)cls;
+ (Class)classWithPropertyName:(NSString *)propertyName
                           cls:(Class)cls;
@end
