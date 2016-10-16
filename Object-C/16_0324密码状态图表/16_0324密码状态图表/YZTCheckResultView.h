//
//  YZTCheckResultView.h
//  16_0324密码状态图表
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//extern const CGFloat YZTCheckResultViewInfoDefaltWidth;

typedef NS_ENUM(NSInteger, YZTCheckResultViewResult){
    YZTCheckResultViewResultNormal = 0,
    YZTCheckResultViewResultRight,
    YZTCheckResultViewResultFalse,
    YZTCheckResultViewResultWarn,
};

typedef NS_ENUM(NSInteger, YZTCheckResultViewPopDirection){
    YZTCheckResultViewPopDirectionLeft,
    YZTCheckResultViewPopDirectionCenter,
    YZTCheckResultViewPopDirectionRight
};

@interface YZTCheckResultView : UIView

@property (nonatomic, assign) CGFloat infoWidth;

- (instancetype)initWithCenter:(CGPoint)center popDirection:(YZTCheckResultViewPopDirection)direction;

- (void)popWithInfo:(NSString *)info resultType:(YZTCheckResultViewResult)result;

- (void)dismiss;

@end

@interface YZTCheckResultViewDetailView : UIView

- (instancetype)initWithHostView:(YZTCheckResultView *)hostView;

@property (nonatomic, weak) YZTCheckResultView *hostView;

- (void)refreshWithInfo:(NSString *)iofo;

@end

@interface NSString(YZTCheckResultView)

- (CGSize)cr_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)cr_widthForFont:(UIFont *)font;

- (CGFloat)cr_heightForFont:(UIFont *)font width:(CGFloat)width;

@end










