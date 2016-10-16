//
//  SecondLoginViewController.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "SecondLoginViewController.h"
#import "YZTLoginModuleManager.h"

@interface SecondLoginViewController ()

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation SecondLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆页面2";
    
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, kScreenWidth-100, 40)];
    _loginBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_loginBtn];
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(startLogining) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startLogining{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loginBtn setTitle:@"登陆成功" forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
    });
    YZTLoginModuleManager *manager = [YZTLoginModuleManager share];
    manager.hasLoginSucess = YES;
}



@end




