//
//  ViewController.m
//  16_0324密码状态图表
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "YZTCheckResultView.h"

@interface ViewController ()

@property (nonatomic, strong) YZTCheckResultView *resultView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _resultView = [[YZTCheckResultView alloc] initWithCenter:CGPointMake(150, 150) popDirection:YZTCheckResultViewPopDirectionLeft];
    [self.view addSubview:_resultView];
//    [_resultView popWithInfo:@"密码正确密码正确密码" resultType:YZTCheckResultViewResultFalse];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_resultView popWithInfo:@"密码正确密码正确密码" resultType:arc4random()%4];
//    [_resultView dismiss];
}


@end
