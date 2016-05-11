//
//  ViewController.m
//  GWExtension
//
//  Created by zhaogw on 16/5/11.
//  Copyright © 2016年 zhaogw. All rights reserved.
//

#import "ViewController.h"
#import "GWExtension.h"
#import "GWSpecialty.h"
#import "GWStudent.h"
#import "GWBook.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  NSLog(@"%@", NSHomeDirectory());
  
  GWSpecialty *c1 = [self createGWSpecialty];
  NSDictionary *dic = [c1 toDic]; //模型转字典
  
  GWSpecialty *c2 = [GWSpecialty toObjWithDic:dic]; //字典转模型
  
  [self saveArchiver:c2]; //对象编码存储
  
  GWSpecialty *c3 = [self loadArchiver]; //对象解码加载
  
  NSLog(@"name: %@", c3.name);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (GWSpecialty *)createGWSpecialty {
  GWSpecialty *c = [[GWSpecialty alloc] init];
  c.name = @"软件工程";
  
  GWBook *b = [[GWBook alloc] init];
  b.name = @"数据结构";
  b.publisher = @"天上人间出版社";
  b.price = 33.5;
  b.image = @"http://www.yuankaifa.com/image.png";
  b.url = [NSURL URLWithString:@"http://www.yuankaifa.com"];
  
  GWStudent *s1 = [[GWStudent alloc] init];
  s1.ID = @"20160011";
  s1.name = @"李磊";
  s1.age = 20;
  s1.sex = SexMale;
  s1.books = @[b];
  
  GWStudent *s2 = [[GWStudent alloc] init];
  s2.ID = @"20160012";
  s2.name = @"韩梅梅";
  s2.age = 20;
  s2.sex = SexFemale;
  s2.books = @[b];
  
  c.students = @[s1, s2];
  
  return c;
}

- (NSString *)filePath:(NSString *)fileName {
  NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
  NSString *p = [path stringByAppendingPathComponent:fileName];
  return p;
}

- (void)saveArchiver:(GWSpecialty *)statusResult {
  NSString *fileName = [self filePath:@"specialty.archiver"];
  NSMutableData* data = [NSMutableData data];
  NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
  [archiver encodeObject:statusResult forKey:@"GWSpecialty"];
  [archiver finishEncoding];
  [data writeToFile:fileName atomically:YES];
}

- (GWSpecialty *)loadArchiver {
  GWSpecialty *obj = nil;
  NSString* fileName = [self filePath:@"specialty.archiver"];
  NSData* data = [NSData dataWithContentsOfFile:fileName];
  if ([data length] > 0) {
    NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    obj = [unArchiver decodeObjectForKey:@"GWSpecialty"];
    [unArchiver finishDecoding];
  }
  return obj;
}

@end
