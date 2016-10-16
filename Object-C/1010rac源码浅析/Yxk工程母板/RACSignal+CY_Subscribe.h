//
//  RACSignal+CY_Subscribe.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "RACSignal.h"
#import "CYSubscriber.h"

@interface RACSignal (CY_Subscribe)


-(void)cySubscribeNext:(nextBlock)next and:(errorBlock)error and:(completeBlock)complete;

@end
