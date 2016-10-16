//
//  ViewController.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "YZTLoginModuleManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"标签栏首页";
    self.view.backgroundColor = arc4RandomColor;
    self.navigationController.navigationBar.translucent = NO;
    
    [[YZTLoginModuleManager share] yzt_registerTaskAfterLogin:^{
        self.view.backgroundColor = [UIColor whiteColor];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestOver];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[FirstViewController new] animated:YES];
}

- (void)requestOver{
    if ([YZTLoginModuleManager share].hasLoginSucess) {
        [self.navigationController pushViewController:[FirstViewController new] animated:YES];
    }
}


@end
