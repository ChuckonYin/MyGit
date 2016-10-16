//
//  RestaurCell.h
//  FoodStore
//
//  Created by liuguopan on 14/12/29.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCButton.h"
#import "VCFixLabel.h"

@interface RestaurCell : UITableViewCell

/**
 *  餐厅图标
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 *  收藏
 */
@property (nonatomic, strong) VCButton    *favoriteButton;

/**
 *  餐厅名称
 */
@property (nonatomic, strong) UILabel     *restaurNameLabel;

/**
 *  评价星级
 */
@property (nonatomic, assign) float       stars;

/**
 *  评论数
 */
@property (nonatomic, strong) UILabel     *reviewsLabel;

/**
 *  月售份数
 */
@property (nonatomic, strong) UILabel     *sellCopiesLable;

/**
 *  人均消费
 */
@property (nonatomic, strong) UILabel     *percapitaExpenseLabel;

/**
 *  运费
 */
@property (nonatomic, strong) UILabel     *freightLabel;

/**
 *  运送时间
 */
@property (nonatomic, strong) UILabel     *freightTimeLabel;

/**
 *  菜系
 */
@property (nonatomic, strong) UILabel     *cuisineLabel;

/**
 *  优惠/提醒
 */
@property (nonatomic, strong) UILabel     *couponTipsLabel;

@end
