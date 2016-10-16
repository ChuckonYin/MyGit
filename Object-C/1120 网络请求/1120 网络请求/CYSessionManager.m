//
//  CYSessionManager.m
//  1120 网络请求
//
//  Created by ChuckonYin on 16/2/1.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYSessionManager.h"
#import <AFNetworking.h>
@implementation CYSessionManager

- (id)share{
    static CYSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CYSessionManager alloc] init];
    });
    return self;
}

- (void)requestWithUrl:(NSString*)url success:(SuccessCallBack)sucess faild:(FaildCallBack)faild{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:@"" parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    return
}



@end
