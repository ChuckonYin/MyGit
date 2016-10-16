//
//  CustomScrView.h
//  AutoScrAds
//
//  Created by sj_w on 15/11/3.
//  Copyright © 2015年 sj_w. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGRect mFrame;
@property (nonatomic, assign) NSInteger curPage;

@property (nonatomic, strong) NSMutableArray *imgData;
@property (nonatomic, strong) NSMutableArray *showImgArr;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic,strong) UIPageControl *pageControl;

- (id)initWithFrame:(CGRect)frame andImgArr:(NSMutableArray *)arr;

@end
