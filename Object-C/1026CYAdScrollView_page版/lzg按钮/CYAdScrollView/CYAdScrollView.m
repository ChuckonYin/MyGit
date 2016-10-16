//
//  CYAdScrollView.m
//
//  Created by ChuckonYin on 15/10/26.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYAdScrollView.h"

@interface CYAdScrollView ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIViewController *_currentVc;
}
@end

@implementation CYAdScrollView


-(instancetype)initWithFrame:(CGRect)frame inteval:(CGFloat)inteval clickIndex:(void(^)(NSInteger clickIndex))callback{
    if (self = [super initWithFrame:frame]) {
        
        _inteval       = inteval;
        _callBack      = callback;
        _focusInterval = 4;
        _isStopRollIntoAdvertisement = NO;
        
        [self creatPageViewContrller];
        
    }
    return self;
}
-(void)creatPageViewContrller
{
    _pageCtrl            = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self addSubview:_pageCtrl.view];
    _pageCtrl.delegate   = self;
    _pageCtrl.dataSource = self;
    _pageCtrl.view.frame = self.bounds;
    
    _pageControl         = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self addSubview:_pageControl];
    _pageControl.center  = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-20);
}

- (void)refrehAdViewwith:(NSArray*)adArr
{
    if (adArr.count<=0) {
        return;
    }
    _timer = [NSTimer timerWithTimeInterval:_inteval target:self selector:@selector(wipeAd) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    _adArr = [adArr mutableCopy];
    _vcArr = [NSMutableArray new];
    for (int i=0; i<_adArr.count; i++) {
        id img               = _adArr[i];
        UIViewController *vc = [[UIViewController alloc] init];
        [vc.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCurrentAdImage)]];
        if (img && [img isKindOfClass:[NSString class]]) {
            vc.view.layer.contents = (__bridge id)[UIImage imageNamed:img].CGImage;
        }
        else if(img && [img isKindOfClass:[UIImage class]]){
            vc.view.layer.contents = (__bridge id)((UIImage*)img).CGImage;
        }
        [_vcArr addObject:vc];
    }
    [_pageCtrl setViewControllers:@[_vcArr[0]] direction:0 animated:NO completion:^(BOOL finished) {
        _currentVc = _vcArr[0];
    }];
    _pageControl.numberOfPages                 = _adArr.count;
    _pageControl.currentPage                   = 0;
    _pageControl.pageIndicatorTintColor        = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
}
-(void)wipeAd
{
    NSInteger index = [_vcArr indexOfObject:_currentVc];
    if (index == _vcArr.count-1) {
        index = 0;
    }
    else{
        index ++;
    }
    _currentVc = _vcArr[index];
    __unsafe_unretained CYAdScrollView *weakSelf = self;
    [_pageCtrl setViewControllers:@[_currentVc] direction:0 animated:YES completion:^(BOOL finished) {
        weakSelf.pageControl.currentPage = index;
    }];
}

#pragma mark - UIPageViewControllerDataSource
/**
 *  以下2代理方法会调用多次，且存在次数上的变更，故不能以此来标记当前页面
 */
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //当有用户交互是暂停滚动数秒
    [self stopToFocus];
    NSInteger index = [_vcArr indexOfObject:viewController];
    if (index>=_vcArr.count-1) {
        index = 0;
    }
    else{
        index ++;
    }
    return _vcArr[index];
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //当有用户交互是暂停滚动数秒
    [self stopToFocus];
    NSInteger index = [_vcArr indexOfObject:viewController];
    if (index<=0) {
        index = _vcArr.count-1;
    }
    else{
        index --;
    }
    return _vcArr[index];
}

#pragma mark - UIPageViewControllerDelegate
//手动滑动时标记当前页码
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    _currentVc               = (UIViewController*)pendingViewControllers[0];
    NSInteger index          = [_vcArr indexOfObject:_currentVc];
    _pageControl.currentPage = index;
}
#pragma mark - EventResponse
//当有用户交互是暂停滚动数秒_focusInterval
-(void)stopToFocus
{
    [_timer setFireDate:[NSDate distantFuture]];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(reRollAgain) withObject:nil afterDelay:_focusInterval];
}
//重新开始滚动
-(void)reRollAgain
{
    [_timer setFireDate:[NSDate date]];
}
#pragma mark - 点击事件回调
- (void)clickCurrentAdImage{
    NSInteger index = [_vcArr indexOfObject:_currentVc];
    if (_callBack) {
         _callBack(index);
        if (_isStopRollIntoAdvertisement)
        {
            [_timer setFireDate:[NSDate distantFuture]];
        }
    }
    NSLog(@"%li",index);
}

@end




