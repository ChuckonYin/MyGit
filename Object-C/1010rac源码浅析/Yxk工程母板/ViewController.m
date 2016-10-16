//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYSubscriber.h"
#import "RACSignal+CY_Subscribe.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *timerSig = [RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler]];
//    [timerSig subscribeNext:^(id x) {
//        NSLog(@"fdsf");
//    }];
    
    CYSubscriber *subscriber = [CYSubscriber subscribeWithNext:^(id value) {
        NSLog(@"next执行完毕");
    } and:^(NSError *error) {
        NSLog(@"error执行完毕");
    } and:^{
        NSLog(@"complete执行完毕");
    }];
    //RACSignal的create初始化和订阅者的指定都是由其子类RACDynamicSignal完成的。
    [timerSig subscribe:subscriber];
//    [timerSig cySubscribeNext:^(id value) {
//        NSLog(@"next");
//    } and:^(NSError *error) {
//
//    } and:^{
//        
//    }];
}


@end
