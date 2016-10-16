//
//  NSObject+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/5.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

///**
// * 打印所有的属性
// */

@interface NSObject (CYAdd)

/* 获取对象的所有属性*/
- (NSArray *)getAllProperties;

/* 获取对象的所有属性 以及属性值 */
- (NSDictionary *)getAllPropertiesAndValue;

/* 控制台输出对象的所有方法 */
-(void)printMothList;
/*判断字符串、数组、字典为nil或为空*/
+(BOOL)isEmptyObject:(id)obj;

@end
