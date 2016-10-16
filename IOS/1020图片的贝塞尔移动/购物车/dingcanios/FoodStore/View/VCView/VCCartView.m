//
//  VCCartView.m
//  FoodStore
//
//  Created by liuguopan on 14/12/30.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCCartView.h"


@implementation VCCartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.18f green:0.22f blue:0.24f alpha:1.00f];
        
        [self createSettleAccountButton];
        [self createCartImageView];
        [self createCopiesLabel];
        [self createPriceLabel];
    }
    return self;
}

- (void)createCartImageView
{
    UIImageView *cartImageView = [[UIImageView alloc] init];
    cartImageView.frame = CGRectMake(8.0f, 10.0f, 25.0f, 20.0f);
    [cartImageView setImage:[UIImage imageNamed:@"cart.png"]];
    [self addSubview:cartImageView];
}

- (void)createCopiesLabel
{
    UILabel *copiesLabel = [[UILabel alloc] init];
    copiesLabel.frame = CGRectMake(25.0f + 8.0f, 0.0f, 47.0f, 40.0f);
    copiesLabel.backgroundColor = [UIColor clearColor];
    copiesLabel.text = @"0份";
    copiesLabel.textColor = [UIColor whiteColor];
    copiesLabel.textAlignment = NSTextAlignmentCenter;
    copiesLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:copiesLabel];
    self.copiesLabel = copiesLabel;
}

- (void)createPriceLabel
{
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(8.0f + 25.0f + 40.0f, 0.0f, 80.0f, 40.0f);
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.text = @"$0";
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
}

- (void)createSettleAccountButton
{
    UIButton *settleAccountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settleAccountButton.frame = CGRectMake(SELF_WIDTH - 80.0f, 8.0f, 72.0f, 24.0f);
    settleAccountButton.backgroundColor = [UIColor grayColor];
    [settleAccountButton setTitle:@"去结算" forState:UIControlStateNormal];
    [settleAccountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    settleAccountButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    settleAccountButton.layer.cornerRadius = 2.0f;
    [self addSubview:settleAccountButton];
    self.settleAccountButton = settleAccountButton;
}

#pragma mark -
#pragma mark - 事件处理

- (void)addFood:(FoodInfo *)food
{
    
}

- (void)removeFood:(FoodInfo *)food
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
