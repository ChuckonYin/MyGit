//
//  BezierViewController.m
//  1030_CAAnimationGroup
//
//  Created by ChuckonYin on 15/11/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "BezierViewController.h"
#import "AlbumViewController.h"

@interface BezierViewController ()
{
    CALayer *_layer;
}
@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor              = [UIColor whiteColor];

    //自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds                          = CGRectMake(0, 0, 50, 80);
    _layer.position                        = CGPointMake(50, 150);
    _layer.anchorPoint                     = CGPointMake(0.5, 0.6);//设置锚点
    _layer.contents=(id)[UIImage imageNamed:@"girl.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self beginAnimate];
}

-(void)beginAnimate{

    CAKeyframeAnimation *keyAnim           = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    UIBezierPath *path                     = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 250) radius:100 startAngle:0 endAngle:2*M_PI clockwise:YES];

    keyAnim.path                           = path.CGPath;

    keyAnim.duration                       = 6;

    [_layer addAnimation:keyAnim forKey:@"bezierAnimation"];
}

-(void)push
{
    [self.navigationController pushViewController:[AlbumViewController new] animated:YES];
}










@end
