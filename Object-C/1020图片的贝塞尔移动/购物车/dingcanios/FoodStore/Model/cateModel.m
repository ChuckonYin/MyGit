//
//  cateModel.m
//  FoodStore
//
//  Created by liuguopan on 15/6/17.
//  Copyright (c) 2015年 liuguopan. All rights reserved.
//

#import "cateModel.h"

@implementation cateModel
- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+ (cateModel *)modelWithDic:(NSDictionary *)dic {
    return [[cateModel alloc] initWithDic:dic];
}
@end
