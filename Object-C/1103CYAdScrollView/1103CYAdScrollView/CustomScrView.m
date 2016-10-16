//
//  CustomScrView.m
//  AutoScrAds
//
//  Created by sj_w on 15/11/3.
//  Copyright © 2015年 sj_w. All rights reserved.
//

#import "CustomScrView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenHeight [UIScreen mainScreen].bounds.size.height


static UIImageView *imgV;

@implementation CustomScrView

//图片的数据源来自应用程序，而不是本身这个类
- (id)initWithFrame:(CGRect)frame andImgArr:(NSMutableArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //初始化成员变量
        _imgData = [arr mutableCopy];//深拷贝，引用计数会加1,需要release
        NSLog(@"%@",_imgData);
        
        self.showImgArr = [[NSMutableArray alloc] initWithCapacity:3];
        self.mFrame = frame;
        self.curPage = 0;
        
        UIView *scrBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mFrame.size.width, self.mFrame.size.height-30)];
        [self addSubview:scrBgView];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.mFrame];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor orangeColor];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(self.mFrame.size.width*3, self.mFrame.size.height);
        
        [scrBgView addSubview:self.scrollView];
        
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), kScreenWidth, 30)];
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageControl.numberOfPages = arr.count;
        [self addSubview:self.pageControl];
        
        [self refreshScrollView];
        
        
    }
    return self;
}

-(NSInteger)beyondIndex:(NSInteger)x {
    if (x < 0) {
        x = [self.imgData count] - 1;
    }
    
    if (x >[self.imgData count] -1) {
        x = 0;
    }
    
    return x;
}

-(void)refreshScrollView {
    //每一次刷新都重新更新数据源（3张图片数据）
    if ([self.showImgArr count] != 0) {
        [self.showImgArr removeAllObjects];
    }
    
    //移除上一次的UIImageView
    for (UIView *v in self.scrollView.subviews) {
        [v removeFromSuperview];
    }
    
    //每一次刷新都获取前一张，当前，下一张图片的索引
    
    NSInteger prePage = [self beyondIndex:self.curPage-1];
    NSInteger curPage = [self beyondIndex:self.curPage];
    NSInteger nextPage = [self beyondIndex:self.curPage + 1];
    
    //从数据源中取出即将显示的三张图片数据
    [self.showImgArr addObject:[self.imgData objectAtIndex:prePage]];
    [self.showImgArr addObject:[self.imgData objectAtIndex:curPage]];
    [self.showImgArr addObject:[self.imgData objectAtIndex:nextPage]];
    
    //刷UIImageView
    for (int i = 0; i < [_showImgArr count]; i++) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mFrame.size.width *i, 0, self.mFrame.size.width, self.mFrame.size.height)];
        [self.imgView setImage:[UIImage imageNamed:[self.showImgArr objectAtIndex:i]]];
//        [self.imgView sizeToFit];
        
        self.imgView.center = CGPointMake(self.mFrame.size.width*i +self.mFrame.size.width/2, self.mFrame.size.height/2);
        
        [self.scrollView addSubview:self.imgView];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.mFrame.size.width, 0)];
    
    NSLog(@"currpage %ld",curPage);
    self.pageControl.currentPage = curPage;
    
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //根据_curPage更新即将显示的图片数据
    if (scrollView.contentOffset.x >= 2*self.mFrame.size.width) {
        _curPage = [self beyondIndex:_curPage + 1];
        [self refreshScrollView];
    }
    
    if (scrollView.contentOffset.x <= 0) {
        self.curPage = [self beyondIndex:self.curPage - 1];
        [self refreshScrollView];
    }
    
}



@end
