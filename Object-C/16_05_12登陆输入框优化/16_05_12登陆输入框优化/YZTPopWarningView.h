//
//  YZTPopWarningView.h
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/13.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ENUM(NSInteger, YZTPopWarningViewType){
    YZTPopWarningViewTypeUp,
    YZTPopWarningViewTypeDown,
};

@interface YZTPopWarningView : UIView

+ (YZTPopWarningView *)yzt_showWarning:(NSString *)warning
                                OnView:(UIView *)superView
                           topLocation:(CGPoint)topLocation
                         horizontalOff:(CGFloat)off
                          selectAction:(void(^)(NSInteger))selectAction;

- (void)yzt_dismiss;

@end
