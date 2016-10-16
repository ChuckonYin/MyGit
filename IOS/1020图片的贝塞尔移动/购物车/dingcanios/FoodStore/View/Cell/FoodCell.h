//
//  FoodCell.h
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCButton.h"
#import "VCStarsImageView.h"

@interface FoodCell : UITableViewCell

/**
 *  美食图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *foodIconImgView;

/**
 *  美食名称
 */
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;

/**
 *  单价
 */
@property (weak, nonatomic) IBOutlet UILabel *foodPriceLabel;

/**
 *  点赞数
 */
@property (weak, nonatomic) IBOutlet UILabel *foodPraisesLabel;

/**
 *  从购物车减去一份该美食
 */
@property (weak, nonatomic) IBOutlet VCButton *foodMinusBtn;

/**
 *  添加到购物车中的该美食的份数
 */
@property (weak, nonatomic) IBOutlet UILabel *foodCopiesLabel;

/**
 *  向购物车中添加美食
 */
@property (weak, nonatomic) IBOutlet VCButton *foodAddBtn;

/**
 *  收藏美食
 */
@property (weak, nonatomic) IBOutlet VCButton *foodFavoriteBtn;

@property (nonatomic, strong) VCStarsImageView *starsView;


@end
