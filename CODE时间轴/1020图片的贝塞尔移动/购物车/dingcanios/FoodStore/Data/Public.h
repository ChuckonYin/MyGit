//
//  Public.h
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
@interface Public : NSObject

@property (nonatomic,strong) UserInfo * userInfo;
@property (nonatomic,strong) AddressInfo * addressInfo;
@property (nonatomic,strong) RestaurInfo * restInfo;
@property (nonatomic,strong) CartInfo * cartInfo;
@property (nonatomic,assign) long long dataBites;
/**
 *  网络状态
 */
@property (nonatomic, assign) NetworkStatusType networkState;

/**
 *  @brief  单例，共享数据
 *  @return Public *
 */
+ (Public *)sharedPublic;
+ (NSString *)getMac;

@end
