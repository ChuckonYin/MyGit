//
//  ViewController.m
//  1120 网络请求
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"1447948800";
    
    NSDate *dat = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    
    NSOperationQueue *queque = [[NSOperationQueue alloc] init];
    [queque addOperationWithBlock:^{
        
    }];
    [queque addOperations:nil waitUntilFinished:YES];
    
    AFHTTPSessionManager *mg = [[AFHTTPSessionManager alloc] init];
    
    [mg GET:nil parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}












@end
