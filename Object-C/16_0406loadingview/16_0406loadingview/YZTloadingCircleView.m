//
//  YZTloadingView.m
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/4/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTloadingCircleView.h"

NSString *const YZTloadingView_AnimationKey = @"YZTloadingView_AnimationKey";

@interface YZTloadingCircleView()

@property (nonatomic, assign) CGFloat minWidth;

@property (nonatomic, assign) CGPoint mCenter;

@property (nonatomic, strong) CALayer *bgLayer;

@property (nonatomic, strong) CALayer *aniationLayer;

@property (nonatomic, strong) CABasicAnimation* rotationAnimation;

@property (nonatomic, strong) UIView *bgCover;

//@property (nonatomic, strong) UILabel *dscLabel;

@end

@implementation YZTloadingCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
        _mCenter = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        _minWidth = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*0.8;
        self.backgroundColor = [UIColor clearColor];
        _rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
        _rotationAnimation.duration = 1;
        _rotationAnimation.cumulative = YES;
        _rotationAnimation.repeatCount = NSIntegerMax;
        _bgCoverAlpha = 0.6;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgCover];
    [self.layer addSublayer:self.bgLayer];
    [self.layer addSublayer:self.aniationLayer];
}

- (UIView *)bgCover{
    if (!_bgCover) {
        _bgCover = [[UIView alloc] initWithFrame:self.bounds];
        _bgCover.backgroundColor = [UIColor blackColor];
        _bgCover.alpha = _bgCoverAlpha;
    }
    return _bgCover;
}

- (CALayer *)bgLayer{
    if (!_bgLayer) {
        _bgLayer = [CALayer layer];
        _bgLayer.frame = CGRectMake(0, 0, _minWidth, _minWidth);
        _bgLayer.position = _mCenter;
        _bgLayer.contents = (id)([UIImage imageNamed:@"loadingView_bg"].CGImage);
    }
    return _bgLayer;
}

- (CALayer *)aniationLayer{
    if (!_aniationLayer) {
        _aniationLayer = [CALayer layer];
        _aniationLayer.frame = self.bgLayer.frame;
        _aniationLayer.position = _mCenter;
        _aniationLayer.contents = (id)([UIImage imageNamed:@"loadingView_half"].CGImage);
    }
    return _aniationLayer;
}

- (void)startAnimation:(NSString *)text{
//    _dscLabel.text = text;
    [_aniationLayer addAnimation:_rotationAnimation forKey:YZTloadingView_AnimationKey];
}

- (void)stopAnimation{
    [_aniationLayer removeAnimationForKey:YZTloadingView_AnimationKey];
}

- (void)setInterval:(NSTimeInterval)interval{
    _interval = interval;
    _rotationAnimation.duration = _interval;
}

- (void)setBgCoverAlpha:(CGFloat)bgCoverAlpha{
    _bgCoverAlpha = bgCoverAlpha;
    _bgCover.alpha = _bgCoverAlpha;
}
//
//- (void)resetDscText:(NSString *)dsc{
//    _dscLabel.text = dsc;
//}

@end
