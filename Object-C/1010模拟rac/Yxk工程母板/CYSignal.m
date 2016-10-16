//
//  CYSignal.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYSignal.h"

@implementation CYSignal

-(void)cySubscribeNext:(cySubscribeBlock)subscribe{
    _subbriber = [[CYSubcriber alloc] init];
    _subscribe = subscribe;
}

-(void)cySendNext
{
    _subscribe(@"wwwwwwwww");
    NSLog(@"cySendNext");
}
@end
