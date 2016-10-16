//
//  WealthAcceleratorView.h
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WealthAcceleratorViewLevel){
    WealthAcceleratorViewLevelBad = 0,  // 较差
    WealthAcceleratorViewLevelDeveloping = 1, // 待提升
    WealthAcceleratorViewLevelNormal = 2, // 一般
    WealthAcceleratorViewLevelGood = 3, // 良好
    WealthAcceleratorViewLevelExcellent = 4 // 优秀
};

#define kScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define WealthAcceleratorViewHeight (WealthAcceleratorViewR3 + 80.0 + WealthAcceleratorViewBottomHeight)
//extern const CGFloat WealthAcceleratorViewBottomHeight;
#define kGlobalColor [UIColor colorWithHex:0X2d4486 alpha:1.0]

@interface WealthAcceleratorView : UIView

- (void)refreshWithLevel:(WealthAcceleratorViewLevel )level precisePercent:(NSString *)precisePercent animated:(BOOL)animated;

@end

@interface WealthAcceleratorViewWhiteGradientLine: UIView

@end

@interface WealthAcceleratorViewArrow : UIView

@property (nonatomic, strong, readonly) UIColor *color;

- (void)refreshColor:(UIColor *)color;

@end

@interface UIColor(YZT)

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

@end








