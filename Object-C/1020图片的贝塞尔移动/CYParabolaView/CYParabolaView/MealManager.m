//
//  MealManager.m
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "MealManager.h"
#import "MealModel.h"
@implementation MealManager

static MealManager *_m;
+ (id) share{
    dispatch_once_t once;
    dispatch_once(&once, ^{
        _m = [[MealManager alloc] init];
    });
    return _m;
}

-(void)pareData:(id)dict{
    
//    for (int i=0; i<7; i++) {
//        for (j = 0; j < 9; j++) {
//            MealModel *model = [[MealModel alloc] init];
//            [_aWeekArr addObject:model];
//        }
//    }
    for (int i = 0; i < 9; i++) {
        MealModel *model = [[MealModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_aDayArr addObject:model];
    }
}






@end
