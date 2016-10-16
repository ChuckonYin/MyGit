//
//  SubmitFourthCell.m
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "SubmitFourthCell.h"
#import "VCSubmitView.h"

@interface SubmitFourthCell ()

@property (nonatomic, strong) VCSubmitView *bgView;

@end

@implementation SubmitFourthCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        [self createBackgroundView];
        [self createTitleLabel];
        [self createPayView];
    }
    return self;
}

- (void)createBackgroundView
{
    VCSubmitView *bgView = [[VCSubmitView alloc] init];
    bgView.frame = CGRectMake(5.0f, 4.0f, SCREEN_WIDTH - 5.0f - 5.0f, 138.0f);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.isTop = NO;
    [self addSubview:bgView];
    self.bgView = bgView;
}

- (void)createTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10.0f, 0, 150.0f, 30.0f);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"请选择支付方式";
    titleLabel.textColor = [UIColor colorWithRed:0.34f green:0.34f blue:0.34f alpha:1.00f];
    titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:titleLabel];
}

- (void)createPayView
{
    UILabel *payOnDeliveryTitleLabel = [[UILabel alloc] init];
    payOnDeliveryTitleLabel.frame = CGRectMake(10.0f, 30.0f, 150.0f, 36.0f);
    payOnDeliveryTitleLabel.backgroundColor = [UIColor clearColor];
    payOnDeliveryTitleLabel.text = @"餐到付款";
    payOnDeliveryTitleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:payOnDeliveryTitleLabel];
    
    UIButton *payOnDeliveryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payOnDeliveryButton.frame = CGRectMake(0, 30.0f, self.bgView.frame.size.width, 36.0f);
    payOnDeliveryButton.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:payOnDeliveryButton];
    self.payOnDeliveryButton = payOnDeliveryButton;
    
    
    UILabel *payOnlineLabel = [[UILabel alloc] init];
    payOnlineLabel.frame = CGRectMake(10.0f, 30.0f + 36.0f, 150.0f, 20.0f);
    payOnlineLabel.backgroundColor = [UIColor clearColor];
    payOnlineLabel.text = @"在线支付";
    payOnlineLabel.textColor = [UIColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:1.00f];
    payOnlineLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:payOnlineLabel];
    self.payOnlineLabel = payOnlineLabel;
    
    UILabel *payOnlineLabel2 = [[UILabel alloc] init];
    payOnlineLabel2.frame = CGRectMake(10.0f, 30.0f + 36.0f + 20, 150.0f, 16.0f);
    payOnlineLabel2.backgroundColor = [UIColor clearColor];
    payOnlineLabel2.text = @"餐厅不支持在线支付";
    payOnlineLabel2.textColor = [UIColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:1.00f];
    payOnlineLabel2.font = [UIFont systemFontOfSize:11.0f];
    [self.bgView addSubview:payOnlineLabel2];
    self.payOnlineLabel2 = payOnlineLabel2;
    
    UIButton *payOnlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payOnlineButton.frame = CGRectMake(0, 30.0f + 36.0f, self.bgView.frame.size.width, 36.0f);
    payOnlineButton.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:payOnlineButton];
    self.payOnDeliveryButton = payOnlineButton;
    
    
    UILabel *payOnAppLabel = [[UILabel alloc] init];
    payOnAppLabel.frame = CGRectMake(10.0f, 30.0f + 36.0f + 36.0, 150.0f, 20.0f);
    payOnAppLabel.backgroundColor = [UIColor clearColor];
    payOnAppLabel.text = @"余额支付";
    payOnAppLabel.textColor = [UIColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:1.00f];
    payOnAppLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.bgView addSubview:payOnAppLabel];
    self.payOnAppLabel = payOnAppLabel;
    
    UILabel *payOnAppLabel2 = [[UILabel alloc] init];
    payOnAppLabel2.frame = CGRectMake(10.0f, 30.0f + 36.0f + 36.0 + 20, 150.0f, 16.0f);
    payOnAppLabel2.backgroundColor = [UIColor clearColor];
    payOnAppLabel2.text = @"可用余额：$50";
    payOnAppLabel2.textColor = [UIColor colorWithRed:0.74f green:0.74f blue:0.74f alpha:1.00f];
    payOnAppLabel2.font = [UIFont systemFontOfSize:11.0f];
    [self.bgView addSubview:payOnAppLabel2];
    self.payOnAppLabel2 = payOnAppLabel2;
    
    UIButton *payOnApp = [UIButton buttonWithType:UIButtonTypeCustom];
    payOnApp.frame = CGRectMake(0, 30.0f + 36.0f + 36.0f, self.bgView.frame.size.width, 36.0f);
    payOnApp.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:payOnApp];
    self.payOnDeliveryButton = payOnApp;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
