//
//  ViewController.m
//  test
//
//  Created by ChuckonYin on 16/4/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *img = [self getGradientImg:[UIScreen mainScreen].bounds.size];
    self.view.layer.contents = (id)(img.CGImage);
    
}


- (UIImage *)getGradientImg:(CGSize)size{
    CALayer *baseLayer = [CALayer layer];
    baseLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [self.view.layer addSublayer:baseLayer];
    baseLayer.backgroundColor = [UIColor colorWithRed:0.66 green:0.71 blue:0.80 alpha:1.00].CGColor;
    
    CAGradientLayer *rightUpLayer = [CAGradientLayer layer];
    rightUpLayer.frame = CGRectMake(0, 0, size.width/2.0, size.height/2.0);
    rightUpLayer.startPoint = CGPointMake(0, 0);
    rightUpLayer.endPoint = CGPointMake(1, 1);
    rightUpLayer.colors = @[(id)([UIColor colorWithRed:0.23 green:0.48 blue:0.86 alpha:1.00].CGColor), (id)([UIColor colorWithRed:0.38 green:0.57 blue:0.86 alpha:1.00].CGColor)];
    //    rightUpLayer.colors = @[(id)([UIColor redColor].CGColor),(id)([UIColor redColor].CGColor)];
    [baseLayer addSublayer:rightUpLayer];
    
    CAGradientLayer *rightDownLayer = [CAGradientLayer layer];
    rightDownLayer.frame = CGRectMake(size.width/2.0, size.height/2.0, size.width/2.0, size.height/2.0);
    rightDownLayer.startPoint = CGPointMake(1, 0);
    rightDownLayer.endPoint = CGPointMake(0.2, 0.95);
    rightDownLayer.colors = @[(id)([UIColor colorWithRed:0.38 green:0.57 blue:0.86 alpha:1.00].CGColor),(id)([UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.00].CGColor)];
    [baseLayer addSublayer:rightDownLayer];
    
    UIGraphicsBeginImageContext(baseLayer.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [baseLayer removeFromSuperlayer];
    return img;
}



@end
