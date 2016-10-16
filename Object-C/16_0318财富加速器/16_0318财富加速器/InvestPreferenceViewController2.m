//
//  InvestPreferenceViewController.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "InvestPreferenceViewController2.h"
#import "InvestProrportionViewController.h"
#import "InvestProfitTrendsViewController.h"
#import "InvestProfitDistributionViewController.h"
#import "BlockManager.h"

@interface InvestPreferenceViewController2 ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray <UIViewController *>*pageCtrls;

@end

@implementation InvestPreferenceViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self initUI];
}

- (void)initUI{
    [self.view addSubview:self.pageViewController.view];
}

- (void)doSomething{
    NSLog(@"%s", __func__);
}

- (void)dealloc{
    NSLog(@"%s", __func__);
}

#pragma mark - UIPageViewControllerDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    return nil;
}

#pragma mark - get & set

-(UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        self.pageCtrls = [[NSMutableArray alloc] init];
//        //投资占比
        InvestProrportionViewController *prorportionCtrl = [[InvestProrportionViewController alloc] init];
        [self.pageCtrls addObject:prorportionCtrl];
        //收益走势
        InvestProfitTrendsViewController *trendsCtrl = [[InvestProfitTrendsViewController alloc] init];
        [self.pageCtrls addObject:trendsCtrl];
        //盈亏分布
        InvestProfitDistributionViewController *distributionCtrl = [[InvestProfitDistributionViewController alloc] init];
        [self.pageCtrls addObject:distributionCtrl];
        [_pageViewController setViewControllers:@[_pageCtrls[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    }
    return _pageViewController;
}


@end





