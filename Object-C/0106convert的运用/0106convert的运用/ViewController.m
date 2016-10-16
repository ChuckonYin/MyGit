//
//  ViewController.m
//  0106convert的运用
//
//  Created by ChuckonYin on 16/1/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 200)];
    [self.view addSubview:backView];
    
    UIView *childView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    [backView addSubview:childView];
    
    CGRect r = [childView convertRect:childView.bounds toView:self.view];
    
    NSLog(@"%@", NSStringFromCGRect(r));
    
    
}


@end
