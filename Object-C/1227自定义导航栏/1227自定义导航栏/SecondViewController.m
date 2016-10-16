//
//  SecondViewController.m
//  1227自定义导航栏
//
//  Created by ChuckonYin on 15/12/27.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.fullScreenInteractivePopGestureRecognizer = YES;
    
    self.title = @"cecond";
    self.view.backgroundColor = [UIColor redColor];
    
}


@end
