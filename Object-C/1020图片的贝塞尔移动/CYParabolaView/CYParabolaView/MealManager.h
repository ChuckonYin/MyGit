//
//  MealManager.h
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealManager : NSObject

@property (nonatomic, strong) NSMutableArray *aWeekArr; //二维数组菜单

@property (nonatomic, strong) NSMutableArray *aDayArr; //一天彩蛋


+ (id)share;

-(void)pareData:(id)dict;


@end
