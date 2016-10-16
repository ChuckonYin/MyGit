//
//  CYSignalQueue.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYSignalQueue.h"

@implementation CYSignalQueue

static CYSignalQueue *_queue;

+(id)queue
{
    dispatch_once_t once;
    dispatch_once(&once, ^{
        _queue = [self alloc];
    });
    [_queue initData];
    return _queue;
}
-(void)initData
{
    _signalArr = [NSMutableArray new];
}

-(void)addCYSignal:(CYSignal*)signal
{
//    _currentSignal = signal;
    [_signalArr addObject:signal];
}
@end
