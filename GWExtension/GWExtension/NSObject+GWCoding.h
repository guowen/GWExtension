//
//  NSObject+GWCoding.h
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/10.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GWCoding)
/**
 *  解码（从文件中解析对象）
 */
- (void)decode:(NSCoder *)decoder;
/**
 *  编码（将对象写入文件中）
 */
- (void)encode:(NSCoder *)encoder;
@end
