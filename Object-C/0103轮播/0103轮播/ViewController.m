//
//  ViewController.m
//  0103轮播
//
//  Created by ChuckonYin on 16/1/3.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYAdScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CYAdScrollView *adScroll = [[CYAdScrollView alloc] initWithFrame:CGRectMake(50, 100, 300, 200)];
    [self.view addSubview:adScroll];
    
    NSArray *imgArr = @[[UIImage imageNamed:@"1.jpg"],[UIImage imageNamed:@"2.jpg"],[UIImage imageNamed:@"3.png"]];
    [adScroll refreshWithImageArray:imgArr];
    
}

@end
