//
//  StarView.m
//  1104翻转
//
//  Created by ChuckonYin on 15/11/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "StarView.h"

@interface StarView()
{
    NSTimer *_timer;
    NSInteger *_hlStarNum;
    UIImage *_highLightIMG;
    UIImage *_normalIMG;
    NSInteger _timerRec;
    UIView *_starView;
    CABasicAnimation *_rotationAnimation;
}
@end


@implementation StarView

static StarView *_h = nil;
+(instancetype)share
{
    static dispatch_once_t onceLock;
    dispatch_once(&onceLock, ^{
        _h = [[StarView alloc]init];
    });
    return _h;
}

-(instancetype)init{
    if (self = [super init]) {
        _timerRec = 0;
    }
    return self;
}
//gap为小星星间距
- (UIView*)creatStarViewCenter:(CGPoint)point HighLightIcon:(NSString*)hl_img normalIcon:(NSString*)img starWidth:(CGFloat)starW starGap:(CGFloat)gap highLightNum:(NSInteger)num
{
    CGFloat starH = starW*IMG_NAME(hl_img).size.height/IMG_NAME(hl_img).size.width;
    CGRect frame = CGRectMake(point.x-gap*2-2.5*starW, point.y-starH/2, starW*5+gap*4, starH);
    UIView *view = [[UIView alloc]initWithFrame:frame];
    for (int i=0; i < 5; i++) {
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(i*(starW+gap), 0, starW, starH)];
        imv.tag = 1990 + i;
        [view addSubview:imv];
        imv.image = IMG_NAME(img);
    }
    //将高亮图单独保存在视图中，以hidden属性为标记。省去设置星星个数时传入
    UIImageView *cacheHighIMG = [[UIImageView alloc]initWithImage:IMG_NAME(hl_img)];
    cacheHighIMG.frame = CGRectMake(-5000, -5000, 1, 1);
    cacheHighIMG.hidden = YES;
    [view addSubview:cacheHighIMG];
    //将普通图单独保存在视图中，以alpha＝0为特殊标记
    UIImageView *cacheNormalIMG = [[UIImageView alloc]initWithImage:IMG_NAME(img)];
    cacheHighIMG.frame = CGRectMake(5000, 5000, 1, 1);
    cacheNormalIMG.alpha = 0;
    [view addSubview:cacheNormalIMG];
    return view;
}

- (void)setStarView:(UIView*)starView highLight:(NSInteger)num
{
    _starView = starView;
    _rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    _rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 1.0 ];
    _rotationAnimation.duration = 2;
    _rotationAnimation.cumulative = YES;
    _rotationAnimation.repeatCount = 100;
//    [imv.layer addAnimation:_rotationAnimation forKey:@"fdsfsa"];
    //取出视图中的缓存图
    for (UIView*view in starView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imv = (UIImageView*)view;
            if (imv.hidden) {
                _highLightIMG = imv.image;
            }
            if (!imv.alpha) {
                _normalIMG = imv.image;
            }
        }
    }
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(rotationHalfCycle) userInfo:nil repeats:YES];
}

- (void)rotationHalfCycle{
    
    NSInteger index = _timerRec/2;
    UIImageView *imv = [_starView viewWithTag:1990 + index];
    //半圈只需要切换图片
    if (_timerRec%2!=0) {
        imv.image = _normalIMG;
    }
    //整圈需要切换至下一个图
    else{
        [imv.layer addAnimation:_rotationAnimation forKey:@"fdsfsa"];
    }
        
}


@end
