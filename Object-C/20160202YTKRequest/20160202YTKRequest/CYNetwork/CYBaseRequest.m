//
//  CYBaseRequest.m
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYBaseRequest.h"

@implementation CYBaseRequest

- (void)start{
    [self performSelector:@selector(finish) withObject:nil afterDelay:arc4random()%4];
}

- (void)finish{
    if (_baseDelegate && [_baseDelegate respondsToSelector:@selector(oneRequestfinish:)]) {
        [_baseDelegate oneRequestfinish:self];
    }
}
@end
