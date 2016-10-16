//
//  BlockManager.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "BlockManager.h"

@implementation BlockManager

+ (id)share{
    static BlockManager *sharedObj  = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObj = [[self alloc] init];
    });
    return sharedObj;
}

@end
