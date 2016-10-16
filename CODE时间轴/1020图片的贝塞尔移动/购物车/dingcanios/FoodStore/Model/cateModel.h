//
//  cateModel.h
//  FoodStore
//
//  Created by liuguopan on 15/6/17.
//  Copyright (c) 2015年 liuguopan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cateModel : NSObject
@property(nonatomic,copy)NSString *cate_name;

@property(nonatomic,copy)NSString *cate_id;
@property(nonatomic,copy)NSString *admin_template_cat;

@property(nonatomic,copy)NSString *admin_template_info;
@property(nonatomic,copy)NSString *admin_template_list;

@property(nonatomic,copy)NSString *if_show;
@property(nonatomic,copy)NSString *parent_id;

@property(nonatomic,copy)NSString *sort_order;
@property(nonatomic,copy)NSString *template_cat;
@property(nonatomic,copy)NSString *template_info;

@property(nonatomic,copy)NSString *template_list;
+(cateModel *)modelWithDic:(NSDictionary *)dic;
@end
