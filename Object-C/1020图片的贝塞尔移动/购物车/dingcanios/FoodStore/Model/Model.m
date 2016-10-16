//
//  BaseInfo.m
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "Model.h"

@implementation Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end



@implementation UserInfo

@end



@implementation AddressInfo

@end



@implementation RestaurInfo

@end



@implementation RestaurOption

@end

@implementation OrderMainInfo

@end

@implementation FoodInfo

@end

@implementation PayInfo

@end

@implementation PeisongInfo

@end

@implementation CartInfo

- (NSMutableArray *)foodsArray
{
    if (_foodsArray == nil) {
        _foodsArray = [[NSMutableArray alloc] init];
    }
    return _foodsArray;
}

@end


@implementation CartFoodInfo

@end



@implementation OrderInfo

@end



@implementation SearchInfo


@end

