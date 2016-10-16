//
//  ViewController.m
//  1020text
//
//  Created by ChuckonYin on 15/10/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    CALayer *view2 = [view.layer mutableCopy];
    view2.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:view2];
    
    UIView *view3 = [view copy];
    [self.view addSubview:view3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
