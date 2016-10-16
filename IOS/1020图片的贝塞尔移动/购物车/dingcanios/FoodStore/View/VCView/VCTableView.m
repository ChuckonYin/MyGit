//
//  VCTableView.m
//  FoodStore
//
//  Created by liuguopan on 14-12-11.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCTableView.h"

@implementation VCTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setHeaderRefreshControl:nil];
    }
    return self;
}

- (void)searchControl
{
    UIRefreshControl *ref = [[UIRefreshControl alloc] init];
    [self addSubview:ref];
    [ref beginRefreshing];
}

- (void)setShowHeaderRefresh:(BOOL)showHeaderRefresh
{
    if (showHeaderRefresh) {
        if (nil == self.headerRefreshControl) {
            UIRefreshControl *ref = [[UIRefreshControl alloc] init];
            self.headerRefreshControl = ref;
        }
    }
}

- (void)setShowFooterRefresh:(BOOL)showFooterRefresh
{
    
}

- (void)beginRefresh:(VCRefreshType)refreshType
{

}

- (void)endRefresh:(VCRefreshType)refreshType
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

@implementation VCTableView (HeaderRefresh)

@dynamic headerRefreshControl;

- (void)setHeaderRefreshControl:(UIRefreshControl *)headerRefreshControl
{
    headerRefreshControl.tag = TAG_MIN / 2;
    [self addSubview:headerRefreshControl];
    [headerRefreshControl addTarget:self
                             action:@selector(headerRefreshAction:)
                   forControlEvents:UIControlEventValueChanged];
}

- (UIRefreshControl *)headerRefreshControl
{
    return (UIRefreshControl *)[self viewWithTag:TAG_MIN / 2 + 1];
}

- (void)headerRefreshAction:(UIRefreshControl *)ref
{
    [_vcDelegate vcTableViewRefresh:VCRefreshTypeHeader stete:VCRefreshStateLoading];
}

@end
