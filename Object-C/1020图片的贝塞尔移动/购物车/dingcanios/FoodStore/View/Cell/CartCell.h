//
//  CartCell.h
//  FoodStore
//
//  Created by liuguopan on 15/1/4.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCButton.h"

@interface CartCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *copiesLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) VCButton *addButton;
@property (nonatomic, strong) VCButton *minusButton;

@end
