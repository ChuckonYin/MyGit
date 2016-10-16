//
//  JSON.h
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSON : NSObject

+ (id)jsonParse:(NSData *)data;

+ (NSMutableArray *)getUser:(NSData *)data;
/**
 *  获取餐厅对象列表
 */
+ (NSMutableArray *)getRestaurs:(NSData *)data;

/**
 *  获取美食对象列表
 */
+ (NSMutableArray *)getFoods:(NSData *)data;

/**
 *  获取购物车中所选美食
 */
+ (NSMutableArray *)getFoodsInShoppingCart:(NSData *)data;

/**
 *  获取地址搜索的信息
 */
+ (NSMutableArray *)getSearchInfo:(NSData *)data;

+ (NSMutableArray *)getPays:(NSData *)data;
+ (NSMutableArray *)getPeisong:(NSData *)data;

+ (NSMutableArray *)getMainOrder:(NSData *)data;
+ (NSMutableArray *)getOrder:(NSData *)data;

@end
