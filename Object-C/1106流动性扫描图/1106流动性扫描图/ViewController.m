//
//  ViewController.m
//  1106流动性扫描图
//
//  Created by ChuckonYin on 15/11/6.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "AssetsDetailView.h"
#import "AssetsMobilityView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AssetsMobilityView *view = [[AssetsMobilityView alloc] initWithFrame:CGRectMake(0, 150, 375, 300)];
    [self.view addSubview:view];
    
    
    UIView *imv = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 50, 50)];
    [self.view addSubview:imv];
    imv.backgroundColor = [UIColor redColor];
    
    CABasicAnimation *_rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    _rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 1.0 ];
    _rotationAnimation.duration = 2;
    _rotationAnimation.cumulative = YES;
    _rotationAnimation.repeatCount = 100;
    [imv.layer addAnimation:_rotationAnimation forKey:@"fdsfsa"];
    
}


@end
