//
//  CYBatchRequestContainer.m
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYBatchRequestGlobalContainer.h"

@implementation CYBatchRequestGlobalContainer

+ (id)share{
    static CYBatchRequestGlobalContainer *container = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        container = [[CYBatchRequestGlobalContainer alloc] init];
    });
    return container;
}

- (void)addBatchRequest:(CYBatchRequest *)batchRequest{
    if (!batchRequest || ![batchRequest isKindOfClass:[CYBatchRequest class]]) return;
    [self.batchRequestContainer addObject:batchRequest];
}

- (void)removeBatchRequest:(CYBatchRequest *)batchRequest{
    if (!batchRequest || ![batchRequest isKindOfClass:[CYBatchRequest class]]) return;
    [self.batchRequestContainer removeObject:batchRequest];
}

- (NSMutableSet *)batchRequestContainer{
    if (!_batchRequestContainer) {
        _batchRequestContainer = [NSMutableSet set];
    }
    return _batchRequestContainer;
}


@end
