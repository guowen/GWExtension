//
//  NSObject+GWToDic.h
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/10.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GWToDic)
/**
 *  通过模型来创建一个字典
 *  @return 字典数组
 */
- (NSDictionary *)toDic;
/**
 *  转换为字典或者数组
 */
- (id)toJsonObj;
/**
 *  转换为JSON 字符串
 */
- (NSString *)toJsonStr;
/**
 *  转换为JSON Data
 */
- (NSData *)toJsonData;
@end
