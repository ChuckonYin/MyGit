//
//  CYParabolaView.m
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/19.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYParabolaView.h"

@implementation CYParabolaView

-(id)initWithSuperView:(UIView*)superView delegate:(id<CYParabolaViewDelegate>)delegate
{
    if (self = [super initWithFrame:superView.bounds]) {
        self.backgroundColor = [UIColor clearColor];
        _delegate = delegate;
    }
    return self;
}

- (void) startMove:(UIImage*)img startCenter:(CGPoint)startP stopCenter:(CGPoint)stopP
          interval:(CGFloat)interval minScale:(CGFloat)minScale callback:(endBlock)endblock
{
    _moveImg = img;
//    [self addSubview:_moveView];
    _startP = startP;
    _stopP = stopP;
    _interval = interval;
    _minScale = minScale;
    [self initView];
    [self createBezierCurve];
    [self groupAnimation];
}

-(void)createBezierCurve{
    _controlP = CGPointMake(_startP.x + (_stopP.x -_startP.x)/2,_startP.y-100);
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:_startP];
    [_path addQuadCurveToPoint:_stopP controlPoint:_controlP];

}
-(void)initView{
    _layer = [CALayer layer];
    _layer.contents = (id)_moveImg.CGImage;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    _layer.frame = CGRectMake(_startP.x, _startP.y, _moveImg.size.width, _moveImg.size.height);
    _layer.backgroundColor = [UIColor whiteColor].CGColor;
    _layer.masksToBounds = YES;
    [self.layer addSublayer:_layer];
}


-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    //设置旋转
//    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = _interval;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:_minScale];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation];
    groups.duration = _interval;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    
    [_layer addAnimation:groups forKey:@"group"];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor lightGrayColor] setStroke];
    [_path stroke];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [_layer animationForKey:@"group"]) {
        [_delegate CYParabolaViewAnimationStop];
        [_layer removeFromSuperlayer];
        _layer = nil;
        [self removeFromSuperview];
    }
}


@end
