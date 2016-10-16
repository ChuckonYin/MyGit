//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshNormalHeader.h"
#import "YZTRefreshCircle.h"

@interface MJRefreshNormalHeader()
{
    __unsafe_unretained YZTRefreshCircle *_arrowView;
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件
- (YZTRefreshCircle *)arrowView
{
    if (!_arrowView) {
        YZTRefreshCircle *arrowView = [[YZTRefreshCircle alloc] initWithFrame:CGRectMake(0, 0, 35, 35) andTotoalTurns:1 circleColor:self.isCustomHeaderColor?[UIColor whiteColor]:[UIColor lightGrayColor]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma makr - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5+50;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
//        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
        
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
//    [self set_yztRefreshCircleState:state];
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        [_arrowView stopTurnning];
        if (oldState == MJRefreshStateRefreshing) {
//            self.arrowView.transform = CGAffineTransformIdentity;
        } else {

        }
    } else if (state == MJRefreshStatePulling) {
        [_arrowView startTurnningFast];
//        NSLog(@"%f", self.scrollView.contentOffset.y);
    } else if (state == MJRefreshStateRefreshing) {
        [_arrowView startTurnningFast];
    }
}

@end
