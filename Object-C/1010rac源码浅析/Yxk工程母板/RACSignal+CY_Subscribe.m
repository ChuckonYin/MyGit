//
//  RACSignal+CY_Subscribe.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "RACSignal+CY_Subscribe.h"

@implementation RACSignal (CY_Subscribe)

-(void)cySubscribeNext:(nextBlock)next and:(errorBlock)error and:(completeBlock)complete
{
    CYSubscriber *sub = [CYSubscriber subscribeWithNext:next and:error and:complete];
    [self subscribe:sub];
}

@end
