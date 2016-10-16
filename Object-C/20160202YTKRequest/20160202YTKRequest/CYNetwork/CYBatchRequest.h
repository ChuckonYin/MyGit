//
//  CYBatchRequest.h
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYBaseRequest.h"
#import "CYBatchRequestGlobalContainer.h"

@class CYBatchRequest;
typedef void(^CYBatchRequestFinishBlock)(CYBatchRequest *);
typedef void(^CYBatchRequestFailedBlock)(CYBatchRequest *);

@protocol CYBatchRequestDelegate <NSObject>

- (void)cy_batchRequestFinishOneRequest;

@end

@interface CYBatchRequest : CYBaseRequest <CYBaseRequestDelegate>

@property (nonatomic, weak) id<CYBatchRequestDelegate>delegate;

@property (nonatomic, copy, readonly) CYBatchRequestFinishBlock finishCallback;

@property (nonatomic, copy, readonly) CYBatchRequestFailedBlock failedCallback;

@property (nonatomic, strong, readonly) NSMutableSet<CYBaseRequest *> *requests;

@property (nonatomic, assign) NSInteger requestFinishedCount;

- (id)initWithBatchRequests:(NSArray<CYBaseRequest *> *)batchRequests;

- (void)startWithFinish:(CYBatchRequestFinishBlock)finish faild:(CYBatchRequestFailedBlock)failed;

@end
