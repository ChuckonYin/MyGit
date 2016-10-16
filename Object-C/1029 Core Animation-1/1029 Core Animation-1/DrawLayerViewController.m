//
//  DrawLayerViewController.m
//  1029 Core Animation-1
//
//  Created by ChuckonYin on 15/10/29.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "DrawLayerViewController.h"

@implementation DrawLayerViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(20, 100, 200, 200);
    [self.view addSubview:view];
    view.backgroundColor = [UIColor lightGrayColor];
    /**
     *  隐性协议
     */
    view.layer.delegate = self;
    [view.layer display];
    
    /**
     *   frame，bounds和center，CALayer对应地叫做frame，bounds和position
     *   当视图旋转时layer的framesize和boundsSize不一致
     */
    view.transform = CGAffineTransformMakeRotation(M_PI/4);
    NSLog(@"%f____%f",view.frame.size.height,view.bounds.size.height);
    
    /**
     *   layer的点击事件
     *   view.layer hitTest:CGPointMake(0, 0);
     */
    
}


-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"开始搭建layer");
    CGContextMoveToPoint(ctx, 0, 0);
    /**
     *  绘制的图形并没有超出范围的权利
     */
    CGContextAddLineToPoint(ctx, 500, 500);
    CGContextStrokePath(ctx);
    
}


@end
