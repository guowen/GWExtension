//
//  NSObject+GWToObj.h
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/9.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GWToObj <NSObject>
@optional
+ (NSDictionary *)arrayElementsClass;
@end

@interface NSObject (GWToObj) <GWToObj>
/**
 *  通过字典来创建一个模型
 *  @return 模型
 */
+ (instancetype)toObjWithDic:(NSDictionary *)dic;
/**
 *  通过字典来转换一个模型
 *  @return 模型
 */
- (instancetype)toObjWithDic:(NSDictionary *)dic;
@end
