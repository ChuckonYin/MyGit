//
//  ViewController.m
//  1030_CAAnimationGroup
//
//  Created by ChuckonYin on 15/10/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/CAAnimation.h>
#import "FirstViewController.h"
#define kBasicAnimation1 @"kBasicAnimation1"

@interface ViewController ()

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
    /**
     *  CAAnimation <CAMediaTiming>
     *  1.CAPropertyAnimation:CABasicAnimation、CAKeyframeAnimation
     *  2.CAAnimationGroup
     *  3.CATransition
     */
    UIImage *img = [UIImage imageNamed:@"girl.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
    _layer = [CALayer layer];
    _layer.delegate = self;
    [self.view.layer addSublayer:_layer];
    _layer.frame = CGRectMake(0, 0, 50, 80);
    _layer.position = CGPointMake(150, 150);
    _layer.contents = (__bridge id _Nullable)(img.CGImage);
}

/**
 *  基础动画
 *
 *  @param location 点击坐标
 */

-(void)translatonAnimation:(CGPoint)location{
    /**
     *  初始化。position属性
     */
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnim.toValue = [NSValue valueWithCGPoint:location];
    /**
     *  初始化。bounds属性
     */
//    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    basicAnim.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    
    basicAnim.repeatCount = 10.5f;
    basicAnim.removedOnCompletion = YES;
    basicAnim.duration = 1.0f;
    basicAnim.delegate = self;
    /**
     *  开始动画并命名
     */
    [_layer addAnimation:basicAnim forKey:kBasicAnimation1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    if ([self.view.layer containsPoint:p]) {
         [self translatonAnimation:p];
    }
}
/**
 *  CAAnimationDelegate
 */
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"start");
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"finish");
}
/**
 *  CALayerDelegate
 */
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"layer_____的代理方法");
}
-(void)push
{
    [self.navigationController pushViewController:[FirstViewController new] animated:YES];
}
@end





