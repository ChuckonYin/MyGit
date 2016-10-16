//
//  CYBatchRequestContainer.h
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYBatchRequest.h"
@class CYBatchRequest;
@interface CYBatchRequestGlobalContainer : NSObject

@property (nonatomic, strong) NSMutableSet *batchRequestContainer;

+ (id)share;

- (void)addBatchRequest:(CYBatchRequest *)batchRequest;

- (void)removeBatchRequest:(CYBatchRequest *)batchRequest;

@end
