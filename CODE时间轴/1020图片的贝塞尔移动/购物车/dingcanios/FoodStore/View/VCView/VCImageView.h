//
//  VCImageView.h
//  Ailv_UI_0902
//
//  Created by liuguopan on 14-9-30.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCImageView;

@protocol VCImageViewDelegate <NSObject>
/**
 *  当点击VCImageView时，调用代理方法
 */
- (void)vcImageViewPress:(VCImageView *)vcImageView;
@optional
/**
 *  video按钮点击时触发此事件
 */
- (void)videoImagePress:(UIButton *)videoButton;
@end

@interface VCImageView : UIImageView
/**
 *  是否可以点击，默认为不可以
 */
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) BOOL videoButtonHidden;
@property (nonatomic, weak) __weak id <VCImageViewDelegate> vcImageViewDelegate;

@end
