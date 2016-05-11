//
//  GWStudent.h
//  SyJsonToModel
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "GWUser.h"

@interface GWStudent : GWUser
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSArray *books;
@property (copy, nonatomic) NSString *desc;
@end
