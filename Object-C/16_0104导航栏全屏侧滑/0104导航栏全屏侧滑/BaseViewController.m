//
//  BaseViewController.m
//  0104导航栏全屏侧滑
//
//  Created by ChuckonYin on 16/1/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewController+CYAdd.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationPopGestureFullScreen];
}


@end
