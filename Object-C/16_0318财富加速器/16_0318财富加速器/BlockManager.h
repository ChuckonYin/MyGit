//
//  BlockManager.h
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack)();

@interface BlockManager : NSObject

@property (nonatomic, copy) CallBack block;

+ (id)share;

@end
