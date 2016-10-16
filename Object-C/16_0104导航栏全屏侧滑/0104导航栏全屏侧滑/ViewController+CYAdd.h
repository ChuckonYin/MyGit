//
//  ViewController+CYAdd.h
//  0104导航栏全屏侧滑
//
//  Created by ChuckonYin on 16/1/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface UIViewController (CYAdd)<UIGestureRecognizerDelegate>

//为导航栏控制器添加全屏手势，最好添在控制器基类。不支持导航栏控制器
- (void)setNavigationPopGestureFullScreen;

@end


@interface UINavigationController(CYAdd)


@end



















