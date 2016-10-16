//
//  CartCell.m
//  FoodStore
//
//  Created by liuguopan on 15/1/4.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "CartCell.h"

@implementation CartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createNameLabel];
        [self createPriceLabel];
        [self createAddButton];
        [self createCopiesLabel];
        [self createMinusButton];
    }
    return self;
}

- (void)createNameLabel
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10.0f, 0, SCREEN_WIDTH - 10.0f - 150.0f, 32.0f);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)createPriceLabel
{ 
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(SCREEN_WIDTH - 60.0f, 0, 50.0f, 32.0f);
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textColor = [UIColor colorWithRed:0.99f green:0.42f blue:0.38f alpha:1.00f];
    priceLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
}

- (void)createAddButton
{
    VCButton *addButton = [VCButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(SCREEN_WIDTH - 55.0f - 40.0f,
                                 0,
                                 40.0f,
                                 32.0f);
    [addButton setImage:[UIImage imageNamed:@"food_add.png"]
               forState:UIControlStateNormal];
    [addButton setImageEdgeInsets:UIEdgeInsetsMake(6.0f, 10.0f, 6.0f, 10.0f)];
    [self addSubview:addButton];
    self.addButton = addButton;
}

- (void)createCopiesLabel
{
    UILabel *copiesLabel = [[UILabel alloc] init];
    copiesLabel.frame = CGRectMake(SCREEN_WIDTH - 55.0f - 40.0f - 20.0f,
                                   10.0f,
                                   20.0f,
                                   12.0f);
    copiesLabel.layer.cornerRadius = 2.0f;
    copiesLabel.backgroundColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
    copiesLabel.textAlignment = NSTextAlignmentCenter;
    copiesLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:copiesLabel];
    self.copiesLabel = copiesLabel;
}

- (void)createMinusButton
{
    VCButton *minusButton = [VCButton buttonWithType:UIButtonTypeCustom];
    minusButton.frame = CGRectMake(SCREEN_WIDTH - 55.0f - 40.0f - 20.0f - 40.0f,
                                   0,
                                   40.0f,
                                   32.0f);
    [minusButton setImage:[UIImage imageNamed:@"food_minus.png"]
                 forState:UIControlStateNormal];
    [minusButton setImageEdgeInsets:UIEdgeInsetsMake(6.0f, 10.0f, 6.0f, 10.0f)];
    [self addSubview:minusButton];
    self.minusButton = minusButton;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
