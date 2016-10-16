//
//  VCCartView.h
//  FoodStore
//
//  Created by liuguopan on 14/12/30.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface VCCartView : UIView

@property (nonatomic, strong) UILabel *copiesLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *settleAccountButton;

- (void)addFood:(FoodInfo *)food;
- (void)removeFood:(FoodInfo *)food;

@end
