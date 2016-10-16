//
//  ViewController.m
//  加载动画
//
//  Created by ChuckonYin on 16/4/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "GCLoadingView.h"

@interface ViewController ()

@property (nonatomic, strong) GCLoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loadingView];
    [self.loadingView startAnimation];
    
}

- (GCLoadingView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[GCLoadingView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 500)];
    }
    return _loadingView;
}


@end
