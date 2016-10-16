//
//  ViewController.m
//  1104翻转
//
//  Created by ChuckonYin on 15/11/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView *fistView;
    UIView *secondView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    fistView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    fistView.tag=100;
    fistView.backgroundColor=[UIColor redColor];
    [self.view addSubview:fistView];
    
    secondView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    secondView.tag=101;
    secondView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:secondView];
    
    
    UIView *_loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, 70, 100)];
    _loadingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_loadingView];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 1.0 ];
    rotationAnimation.duration = 5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100;
    
    [_loadingView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self flip];
}



-(void)flip{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    
//    //这里时查找视图里的子视图（这种情况查找，可能时因为父视图里面不只两个视图）
    NSInteger fist= [[self.view subviews] indexOfObject:[self.view viewWithTag:100]];
    NSInteger seconde= [[self.view subviews] indexOfObject:[self.view viewWithTag:101]];
//
    [self.view exchangeSubviewAtIndex:fist withSubviewAtIndex:seconde];
    
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    
}

@end
