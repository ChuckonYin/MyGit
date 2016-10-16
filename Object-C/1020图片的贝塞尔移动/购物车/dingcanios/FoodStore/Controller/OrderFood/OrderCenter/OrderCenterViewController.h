//
//  OrderCenterViewController.h
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

/// 订单中心

#import "BaseViewController.h"

@interface OrderCenterViewController : BaseViewController

@property (nonatomic,strong) NSString * order_id;
@property (nonatomic,strong) OrderMainInfo * mainInfo;
@property (nonatomic,assign) NSInteger orderState;
@property (nonatomic,assign) BOOL isLast;
@property (nonatomic,strong) NSString * number;
@property (nonatomic,strong) NSString * time;
@property (nonatomic,strong) NSString * liuYan;
@end
