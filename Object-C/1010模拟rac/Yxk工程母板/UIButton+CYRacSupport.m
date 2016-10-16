//
//  UIButton+CYRacSupport.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIButton+CYRacSupport.h"
#import "CYSignalQueue.h"

@implementation UIControl (CYRacSupport)


-(CYSignal*)cyRac_signalForControlEvents:(UIControlEvents)event
{
    CYSignal *signal = [[CYSignal alloc] init];
    
    [[CYSignalQueue queue] addCYSignal:signal];
    
    [self addTarget:signal action:@selector(cySendNext) forControlEvents:event];
    
    return signal;
}

@end
