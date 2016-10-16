//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+CYRacSupport.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *beObserver;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [[UIButton alloc] initWithFrame:self.view.frame];
    [self.view addSubview:btn];
//   /原生
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
////  /rac框架
//    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
//    subscribeNext:^(id x) {
//       printf("%s\n","btnClick");
//    }];
    
//  cyRAC框架
    CYSignal *signal = [btn cyRac_signalForControlEvents:UIControlEventTouchUpInside];
    [signal cySubscribeNext:^(id x) {
         NSLog(@"cyBtnClick_____________%@",x);
//        _beObserver = @"gaibian";
     }];
//    RACSignal *obSignal = RACObserve(self, beObserver);
//    [obSignal subscribeNext:^(id x) {
//        NSLog(@"change");
//    }];
}
-(void)btnClick
{
    _beObserver = @"gaibian";
    printf("%s\n","btnClick");
}

@end
