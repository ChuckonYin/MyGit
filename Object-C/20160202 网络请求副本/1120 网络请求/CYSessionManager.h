//
//  CYSessionManager.h
//  1120 网络请求
//
//  Created by ChuckonYin on 16/2/1.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BatchRequestBlock)();

typedef void(^CompleteBlock)();

typedef void(^SuccessCallBack)(id);

typedef void(^FaildCallBack)(id);

@interface CYSessionManager : NSObject

@property (nonatomic, copy) CompleteBlock complete;

+ (id)share;
/**
 *  @param requests     contain request or url or string
 *  @param batchRequest start all request task
 *  @param complete     call back when all request finish
 */
- (void)performBatchRequests:(NSArray<id> *)requests requestEvent:(BatchRequestBlock)batchRequest complete:(CompleteBlock)complete;

- (void)requestWithUrl:(NSString*)url success:(SuccessCallBack)sucess faild:(FaildCallBack)faild;

@end












