//
//  YZTTitleImageButtun.h
//  16_0224
//
//  Created by ChuckonYin on 16/2/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTTitleImageButtun : UIButton

@property (nonatomic, assign) BOOL isImageHidden;
/**
 *  修复按钮文字图片布局问题
 */
- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;
/**
 *  修复按钮文字图片布局问题
 */
- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

@end
