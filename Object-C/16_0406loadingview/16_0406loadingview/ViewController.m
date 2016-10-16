//
//  ViewController.m
//  16_0406loadingview
//
//  Created by ChuckonYin on 16/4/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "YZTloadingCircleView.h"

NSInteger flag = 0;

@interface ViewController ()

@property (nonatomic, strong) YZTloadingCircleView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _loadingView = [[YZTloadingCircleView alloc] initWithFrame:CGRectMake(100,150, 50, 50)];
    [self.view addSubview:_loadingView];
    _loadingView.interval = 0.5;
//    _loadingView.bgCoverAlpha
    [_loadingView startAnimation:@"页面刷新中"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    flag ++;
    if (flag%2==0) {
        [_loadingView startAnimation:@"页面刷新中"];
    }
    else{
        [_loadingView stopAnimation];
    }
    
}

@end
