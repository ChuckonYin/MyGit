//
//  AFNetViewController.m
//  1203NSURLSession
//
//  Created by ChuckonYin on 16/1/27.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "AFNetViewController.h"
#import <AFNetworking.h>

@interface AFNetViewController ()

@end

@implementation AFNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //创建一个session、config、operationQueue的集合，管理所有请求。
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:nil];
    
    [session POST:@"http://baidu.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    }];
    
    NSURLSessionDataTask *dataTask = [session GET:@"http://baidu.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
    }];
    /*
      1、配置dataTask
        1)从AFURLRequestSerialization中获取request
        2)生成dataTask（在session中同步生成）
        3）为dataTask配置唯一的taskDelegate处理数据返回（delegateContainer[@(task.taskIdentifier)] = delegate）
        4)resume task
      2、开始请求，代理回调
        
     */
    
    
    
}

@end
