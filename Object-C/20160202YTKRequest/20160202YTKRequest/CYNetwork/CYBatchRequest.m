//
//  CYBatchRequest.m
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYBatchRequest.h"

@implementation CYBatchRequest

- (id)initWithBatchRequests:(NSArray<CYBaseRequest *> *)batchRequests{
    if (self = [super init]) {
        _requests = [NSMutableSet setWithArray:batchRequests];
    }
    return self;
}

- (void)startWithFinish:(CYBatchRequestFinishBlock)finish faild:(CYBatchRequestFailedBlock)failed{
    _requestFinishedCount = 0;
    _finishCallback = finish;
    _failedCallback = failed;
    [[CYBatchRequestGlobalContainer share] addBatchRequest:self];
    [self start];
}

- (void)start{
    for (CYBaseRequest *rq in self.requests) {
        rq.baseDelegate = self;
        [rq start];
    }
}

- (void)oneRequestfinish:(CYBaseRequest *)rq{
    _requestFinishedCount ++;
    if (_delegate && [_delegate respondsToSelector:@selector(cy_batchRequestFinishOneRequest)]) {
        [_delegate cy_batchRequestFinishOneRequest];
    }
    if (_requestFinishedCount >= self.requests.count) {
        if (_finishCallback) {
            _finishCallback(self);
        }
        [[CYBatchRequestGlobalContainer share] removeBatchRequest:self];
    }
}


@end





