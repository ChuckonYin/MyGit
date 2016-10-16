//
//  CYSessionManager.m
//  1120 网络请求
//
//  Created by ChuckonYin on 16/2/1.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYSessionManager.h"
#import <AFNetworking.h>

@interface CYSessionManager ()

@property (nonatomic, assign) NSInteger unFinishedBatchRequestCount;

@end

@implementation CYSessionManager

+ (id)share{
    static CYSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CYSessionManager alloc] init];
    });
    return manager;
}

- (void)requestWithUrl:(NSString*)url success:(SuccessCallBack)sucess faild:(FaildCallBack)faild{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:url parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:url object:nil];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (faild) {
            faild(error);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:url object:nil];
    }];
}

- (void)performBatchRequests:(NSArray<id> *)requests requestEvent:(BatchRequestBlock)batchRequest complete:(CompleteBlock)complete{
    self.complete = complete;
    [self registerNotificationWithBatchRequest:requests];
    if (batchRequest) {
        batchRequest();
    }
}

- (void)registerNotificationWithBatchRequest:(NSArray<id> *)requests {
    if (!requests || requests.count==0) return;
    self.unFinishedBatchRequestCount = 0;
    for (id obj in requests) {
        NSString *notiName = [self nameOfRequest:obj];
        if (notiName) {
           [[NSNotificationCenter defaultCenter] removeObserver:self name:notiName object:nil];
           [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveOneRequestFinishNotification:) name:notiName object:nil];
           self.unFinishedBatchRequestCount ++;
        }
    }
}

- (void)recieveOneRequestFinishNotification:(NSNotification*)noti{
    if (--self.unFinishedBatchRequestCount == 0) {
        if (self.complete) {
            self.complete();
        }
    }
}

- (NSString *)nameOfRequest:(id)request{
    if ([request isKindOfClass:[NSString class]]) {
        return request;
    }
    else if ([request isKindOfClass:[NSURL class]]){
        return [(NSURL*)request absoluteString];
    }
    else if ([request isKindOfClass:[NSURLRequest class]]){
        return [[(NSURLRequest*)request URL] absoluteString];
    }
    else{
        return nil;
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
