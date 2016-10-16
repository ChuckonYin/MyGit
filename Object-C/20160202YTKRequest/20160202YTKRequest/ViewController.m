//
//  ViewController.m
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <YTKBatchRequest.h>
#import "CYNetwork/CYBatchRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YTKBaseRequest *rq1 = [[YTKBaseRequest alloc] init];
    YTKBaseRequest *rq2 = [[YTKBaseRequest alloc] init];
    YTKBatchRequest *batchRq = [[YTKBatchRequest alloc] initWithRequestArray:@[rq1, rq2]];
    [batchRq startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
        NSLog(@"%@", batchRequest);
    } failure:^(YTKBatchRequest *batchRequest) {
        NSLog(@"%@", batchRequest);
    }];
//    [batchRq start]
    CYBaseRequest *rq3 = [[CYBaseRequest alloc] init];
    CYBaseRequest *rq4 = [[CYBaseRequest alloc] init];
    CYBatchRequest *rq0 = [[CYBatchRequest alloc] initWithBatchRequests:@[rq3, rq4]];
    [rq0 startWithFinish:^(CYBatchRequest *rq) {
        NSLog(@"________________over");
    } faild:^(CYBatchRequest *rq) {
        NSLog(@">>>>>>>>>>>>>>>>");
    }];
    
}

@end
