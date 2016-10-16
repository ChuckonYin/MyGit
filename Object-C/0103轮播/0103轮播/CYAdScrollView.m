//
//  CYAdScrollView.m
//  0103轮播
//
//  Created by ChuckonYin on 16/1/3.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYAdScrollView.h"

@interface CYAdScrollView ()<UIScrollViewDelegate>
{
    CGFloat mWidth;
    CGFloat mHeight;
    
    NSInteger index0;
    NSInteger index1;
    NSInteger index2;
    NSInteger count;
    
//    NSInteger currentPage;
}
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIImageView *imageView0;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIPageControl *pageCtrl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation CYAdScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        mWidth  = frame.size.width;
        mHeight = frame.size.height;
        
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews
{
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.delegate = self;
    _scroll.contentSize = CGSizeMake(mWidth*3, 0);
//    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scroll];
    
    _imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mWidth, mHeight)];
    _imageView0.backgroundColor = [UIColor redColor];
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(mWidth, 0, mWidth, mHeight)];
    _imageView1.backgroundColor = [UIColor brownColor];
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(mWidth*2, 0, mWidth, mHeight)];
    _imageView2.backgroundColor = [UIColor yellowColor];
    [_scroll addSubview:_imageView0];
    [_scroll addSubview:_imageView1];
    [_scroll addSubview:_imageView2];
    
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, mHeight*0.8, mWidth, 20)];
    _pageCtrl.currentPageIndicatorTintColor = [UIColor yellowColor];
    [self addSubview:_pageCtrl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.x);
//    
    if (_scroll.contentOffset.x <5) {
        [self scrollWillToLeft];
        _scroll.contentOffset = CGPointMake(_scroll.contentOffset.x+mWidth, 0);
    }
    
    if (_scroll.contentOffset.x > mWidth*2-5) {
        [self scrollWillToRight];
        _scroll.contentOffset = CGPointMake(_scroll.contentOffset.x-mWidth, 0);
    }
//
}

- (void)scrollWillToLeft
{
    NSLog(@"%s", __func__);
    
    if (--index0<0) index0 = count-1;
    if (--index1<0) index1 = count-1;
    if (--index2<0) index2 = count-1;
    
    [self reloadImageData];

}
- (void)scrollWillToRight
{
    NSLog(@"%s", __func__);
    
    if (++index0>=count) index0 = 0;
    if (++index1>=count) index1 = 0;
    if (++index2>=count) index2 = 0;
    
    [self reloadImageData];
}

- (void)refreshWithImageArray:(NSMutableArray *)imgArr
{
    _imgArr = imgArr.mutableCopy;
    count = _imgArr.count;
    _pageCtrl.numberOfPages = count;
    index0 = 0;index1 = 1;index2 = 2;
    
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(showNextAdImage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer setFireDate:[NSDate date]];
    }
    
    [self reloadImageData];
}

- (void)reloadImageData
{
    _imageView0.image = _imgArr[index0];
    _imageView1.image = _imgArr[index1];
    _imageView2.image = _imgArr[index2];
    _pageCtrl.currentPage = index0;
}

- (void)setPageIndicatorTintHeight:(CGFloat)pageIndicatorTintHeight
{
    _pageIndicatorTintHeight = pageIndicatorTintHeight;
     _pageCtrl.frame = CGRectMake(0, mHeight*0.8 + _pageIndicatorTintHeight, mWidth, 20);
}

- (void)showNextAdImage
{
    [_scroll setContentOffset:CGPointMake(_scroll.contentOffset.x+mWidth, 0) animated:YES];
}
@end
















