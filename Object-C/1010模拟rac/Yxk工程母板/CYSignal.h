//
//  CYSignal.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CYSubcribe.h"
//#define cySubscribeBlock(block) void(^block)(id x)

typedef void(^cySubscribeBlock)(id x);

@interface CYSignal : NSObject

@property (nonatomic, copy) cySubscribeBlock subscribe;

@property (nonatomic, strong) CYSubcriber *subbriber;

-(void)cySubscribeNext:(cySubscribeBlock)subscribe;

-(void)cySendNext;

@end
