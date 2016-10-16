//
//  CYSubscriber.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYSubscriber.h"

@implementation CYSubscriber

+(id)subscribeWithNext:(nextBlock)next and:(errorBlock)error and:(completeBlock)complete
{
    CYSubscriber *sub = [[self alloc] init];
    sub.next = next;
    sub.error = error;
    sub.complete = complete;
    return sub;
}

- (void)sendNext:(id)value
{
//    NSLog(@"receiveSignal");
    _next?_next(value):nil;
}

- (void)sendError:(NSError *)error
{
//    NSLog(@"error");
    _error(error);
}

- (void)sendCompleted
{
//    NSLog(@"sendCompleted");
    _complete();
}

- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable
{
    NSLog(@"didSubscribeWithDisposable");
}


@end
