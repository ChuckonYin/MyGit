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

- (void) startMove:(UIImageView*)moveView startCenter:(CGPoint)startP stopCenter:(CGPoint)stopP
          interval:(CGFloat)interval minScale:(CGFloat)minScale callback:(endBlock)endblock
{
    _moveView = moveView;
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
    _layer.contents = (__bridge id)[UIImage imageNamed:@"Star 1"].CGImage;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    _layer.bounds = _moveView.bounds;
    _layer.backgroundColor = [UIColor clearColor].CGColor;
    _layer.masksToBounds = YES;
    _layer.position = CGPointMake(_startP.x-_moveView.frame.size.width/2, _startP.y-_moveView.frame.size.height/2);
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
    
//    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    narrowAnimation.beginTime = 0.5;
//    narrowAnimation.duration = 1.5f;
//    narrowAnimation.fromValue = [NSNumber numberWithFloat:0.8f];
//    narrowAnimation.toValue = [NSNumber numberWithFloat:0.2f];
    
//    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
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

//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    //    [anim def];
//    if (anim == [layer animationForKey:@"group"]) {
//        _btn.enabled = YES;
//        [layer removeFromSuperlayer];
//        layer = nil;
//        _cnt++;
//        if (_cnt) {
//            _cntLabel.hidden = NO;
//        }
//        CATransition *animation = [CATransition animation];
//        animation.duration = 0.25f;
//        _cntLabel.text = [NSString stringWithFormat:@"%ld",(long)_cnt];
//        [_cntLabel.layer addAnimation:animation forKey:nil];
//        
//        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//        shakeAnimation.duration = 0.25f;
//        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
//        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
//        shakeAnimation.autoreverses = YES;
//        [_imageView.layer addAnimation:shakeAnimation forKey:nil];
//    }
//}


@end
