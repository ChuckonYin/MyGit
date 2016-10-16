//
//  VCView.h
//  Ailv_UI_0902
//
//  Created by liuguopan on 14-10-10.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCView;
@protocol VCViewDelegate <NSObject>
/**
 *  当点击VCImageView时，调用代理方法
 */
- (void)vcViewPress:(VCView *)vcView;
@end

@interface VCView : UIView
/**
 *  是否可以点击，默认为不可以
 */
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, weak) __weak id <VCViewDelegate> vcViewDelegate;

@end
