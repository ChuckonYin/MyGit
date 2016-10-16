//
//  SubmitFirstCell.m
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "SubmitFirstCell.h"
#import "VCSubmitView.h"

@interface SubmitFirstCell ()

@property (nonatomic, strong) VCSubmitView *bgView;

@end

@implementation SubmitFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        [self createBackgroundView];
        [self createPriceLabel];
        [self createFreightLabel];
        [self createTipButton];
    }
    return self;
}

- (void)createBackgroundView
{
    VCSubmitView *bgView = [[VCSubmitView alloc] init];
    bgView.frame = CGRectMake(5.0f, 4.0f, SCREEN_WIDTH - 5.0f - 5.0f, 90.0f);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.isTop = YES;
    [self addSubview:bgView];
    self.bgView = bgView;
}

- (void)createPriceLabel
{
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(self.bgView.frame.size.width - 100.0f - 10.0f, 0, 100.0f, 30.0f);
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.text = @"$20.00";
    priceLabel.textColor = [UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.bgView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *priceTitleLabel = [[UILabel alloc] init];
    priceTitleLabel.frame = CGRectMake(10.0f, 0, 100.0f, 30.0f);
    priceTitleLabel.backgroundColor = [UIColor clearColor];
    priceTitleLabel.text = @"菜品总额";
    priceTitleLabel.textColor = [UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f];
    priceTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.bgView addSubview:priceTitleLabel];
}

- (void)createFreightLabel
{
    UILabel *freightLabel = [[UILabel alloc] init];
    freightLabel.frame = CGRectMake(self.bgView.frame.size.width - 100.0f - 10.0f, 30.0f, 100.0f, 30.0f);
    freightLabel.backgroundColor = [UIColor clearColor];
    freightLabel.text = @"$1.00";
    freightLabel.textColor = [UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f];
    freightLabel.textAlignment = NSTextAlignmentRight;
    freightLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.bgView addSubview:freightLabel];
    self.freightLabel = freightLabel;
    
    UILabel *freightTitleLabel = [[UILabel alloc] init];
    freightTitleLabel.frame = CGRectMake(10.0f, 30.0f, 165.0f, 30.0f);
    freightTitleLabel.backgroundColor = [UIColor clearColor];
    freightTitleLabel.text = @"Distance price shipping";
    freightTitleLabel.textColor = [UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f];
    freightTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.bgView addSubview:freightTitleLabel];
}

- (void)createTipButton
{
//    UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    tipButton.frame = CGRectMake(self.bgView.frame.size.width - 60.0f, 60.0f, 60.0f, 30.0f);
//    tipButton.backgroundColor = [UIColor clearColor];
//    [tipButton setTitleColor:[UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
//    tipButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    tipButton.titleLabel.textAlignment = NSTextAlignmentRight;
//    [self.bgView addSubview:tipButton];
//    self.tipButton = tipButton;
//    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.frame = CGRectMake(self.bgView.frame.size.width - 100.0f - 10.0f, 60.0f, 100.0f, 30.0f);
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.text = @"$1.00";
    tipLabel.textColor = [UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f];
    tipLabel.textAlignment = NSTextAlignmentRight;
    tipLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.bgView addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    
    UILabel *tipTitleLabel = [[UILabel alloc] init];
    tipTitleLabel.frame = CGRectMake(10.0f, 60.0f, 100.0f, 30.0f);
    tipTitleLabel.backgroundColor = [UIColor clearColor];
    tipTitleLabel.text = @"小费";
    tipTitleLabel.textColor = [UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f];
    tipTitleLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.bgView addSubview:tipTitleLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
