//
//  VCTableView.h
//  FoodStore
//
//  Created by liuguopan on 14-12-11.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  刷新类型
 */
typedef NS_ENUM(NSInteger, VCRefreshType) {
    VCRefreshTypeFooter     = 0,    //  刷新类型 - 下拉刷新
    VCRefreshTypeHeader,            //  刷新类型 - 上拉加载
};

/**
 *  刷新状态
 */
typedef NS_ENUM(NSInteger, VCRefreshState) {
    VCRefreshStateNormal    = 0,    //  刷新状态 - 正常状态
    VCRefreshStatePulling,          //  刷新状态 - 将要刷新
    VCRefreshStateLoading,          //  刷新状态 - 正在刷新
};


@protocol VCTableViewDelegate <NSObject>

@optional
/**
 *  @brief      VCTableView的代理方法
 *  @param      type    刷新类型
 *  @param      state   刷新状态
 */
- (void)vcTableViewRefresh:(VCRefreshType)type stete:(VCRefreshState)state;

@end


/*
    自定义tableView，集成下拉刷新和上拉刷新功能
 */
@interface VCTableView : UITableView<UIScrollViewDelegate>

/**
 *  是否显示顶部下拉刷新视图
 */
@property (nonatomic, assign) BOOL showHeaderRefresh;

/**
 *  是否显示底部上拉加载视图
 */
@property (nonatomic, assign) BOOL showFooterRefresh;

/**
 *  当前状态（正常，将要刷新，正在刷新）
 */
@property (nonatomic, assign) VCRefreshState refreshState;

@property (nonatomic, weak) __weak id <VCTableViewDelegate>vcDelegate;

/**
 *  开始刷新
 */
- (void)beginRefresh:(VCRefreshType)refreshType;
/**
 *  结束刷新
 */
- (void)endRefresh:(VCRefreshType)refreshType;

@end



@interface VCTableView (HeaderRefresh)

/**
 *  下拉刷新视图
 */
@property (nonatomic, strong) UIRefreshControl *headerRefreshControl;

@end



@interface VCTableView (FooterRefresh)

/**
 *  上拉加载更多视图
 */
@property (nonatomic, strong) UIView *footerRefreshView;

/**
 *  活动指示器（菊花）
 */
@property (nonatomic, strong) UIActivityIndicatorView *footerRefreshActivityIndicatorView;

/**
 *  显示文字Label
 */
@property (nonatomic, strong) UILabel *footerRefreshLalbel;

@end
