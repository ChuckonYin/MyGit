//
//  CYSubscriber.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^nextBlock)(id value);
typedef void(^errorBlock)(NSError* error);
typedef void(^completeBlock)();

@interface CYSubscriber : NSObject<RACSubscriber>

@property (nonatomic, copy) nextBlock next;

@property (nonatomic, copy) errorBlock error;

@property (nonatomic, copy) completeBlock complete;

+(id)subscribeWithNext:(nextBlock)next and:(errorBlock)error and:(completeBlock)complete;

- (void)sendNext:(id)value;

- (void)sendError:(NSError *)error;

- (void)sendCompleted;

- (void)didSubscribeWithDisposable:(RACCompoundDisposable *)disposable;


@end
