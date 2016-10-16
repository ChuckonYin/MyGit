//
//  PopView.m
//  16_0531再窥约束
//
//  Created by yinxukun on 16/9/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "PopView.h"
#import "Masonry.h"

@implementation PopView

+ (instancetype)showCustomView:(UIView *)customView onView:(UIView *)onView{
    PopView *popView = [[self alloc] initWithCustomView:(UIView *)customView];
    [onView addSubview:popView];
    [popView yzt_show];
    return popView;
}

- (instancetype)initWithCustomView:(UIView *)customView{
    if (self = [super initWithFrame:CGRectZero]) {
        [self addSubview:customView];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(customView);
        }];
    }
    return self;
}

- (void)yzt_show{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.mas_bottom);
        make.centerX.equalTo(self.superview);
    }];
    [self layoutIfNeeded];
    CGFloat componentHeight = self.bounds.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.superview.mas_bottom).offset(-componentHeight);
            make.centerX.equalTo(self.superview);
        }];
        [self layoutIfNeeded];
    }];
}


@end
