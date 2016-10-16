//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <RACDynamicSignal.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Person *p = [Person new];
//    for (int i = 0; i<10000; i++) {
//        p.dog.name = @"wangzai";
//        p->name = @"jack";
//    }
//    for (int i = 0; i < 10000; i++) {
//        p.dog.name = @"wangzai";
//    }
    
    
    RACSignal *signalA = [RACDynamicSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"signalA"];
        return nil;
    }];
    [signalA subscribeNext:^(id x) {
        NSLog(@"fdsfs____%@",x);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    RACSignal *signalB = [btn rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    [signalB takeUntil:signalA];
    
//    RACDisposable *dis = [signalB subscribeNext:^(id x) {
//        
//    }];
//    NSLog(@"%@",dis!=nil?dis:nil);
    [self rac_liftSelector:@selector(signalAction:and:) withSignals:signalA, signalB, nil];
//
//    RACStream *stream = [RACStream empty];
//    NSLog(@"%@",stream);
   
}

-(void)signalAction:(NSString*)A and:(NSString*)B
{
    NSLog(@"over");
}

@end
