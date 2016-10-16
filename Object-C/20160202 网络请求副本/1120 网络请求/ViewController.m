//
//  ViewController.m
//  1120 网络请求
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYSessionManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CYSessionManager share] performBatchRequests:@[@"http://www.baidu.com", @"http://www.baidu1.com"] requestEvent:^{
        [[CYSessionManager share] requestWithUrl:@"http://www.baidu.com" success:^(id response) {
            NSLog(@"请求1成功：%@", response);
        } faild:^(id erro) {
            NSLog(@"请求失败：%@", erro);
        }];
        [[CYSessionManager share] requestWithUrl:@"http://www.baidu1.com" success:^(id response) {
            NSLog(@"请求1成功：%@", response);
        } faild:^(id erro) {
            NSLog(@"请求失败：%@", erro);
        }];
    } complete:^{
        NSLog(@"所有请求结束");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}












@end
