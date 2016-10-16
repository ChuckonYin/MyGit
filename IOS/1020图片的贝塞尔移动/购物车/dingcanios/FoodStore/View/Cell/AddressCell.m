//
//  AddressCell.m
//  FoodStore
//
//  Created by liuguopan on 15/1/4.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "AddressCell.h"

#define kAddressCellHeight  45.0f

@implementation AddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createAddressLabel];
        [self createTelLabel];
//        [self createTickImageView];
    }
    return self;
}

- (void)createAddressLabel
{
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.frame = CGRectMake(10.0f, 0, 250.0f, kAddressCellHeight / 2);
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.text = @"微斯特尔德伦购物中心";
    addressLabel.textColor = [UIColor colorWithRed:0.32f green:0.32f blue:0.32f alpha:1.00f];
    addressLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:addressLabel];
    self.addressLabel = addressLabel;
}

- (void)createTelLabel
{
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.frame = CGRectMake(10.0f, kAddressCellHeight / 2, 250.0f, kAddressCellHeight / 2);
    telLabel.backgroundColor = [UIColor clearColor];
    telLabel.text = @"18663495673";
    telLabel.textColor = [UIColor colorWithRed:0.32f green:0.32f blue:0.32f alpha:1.00f];
    telLabel.font = [UIFont systemFontOfSize:14.0f];
    [self addSubview:telLabel];
    self.telLabel = telLabel;
}

- (void)createTickImageView
{
    UIImageView *tickImageView = [[UIImageView alloc] init];
    tickImageView.frame = CGRectMake(SCREEN_WIDTH - 5.0f - 12.0f - 11.0f,
                                     kAddressCellHeight / 2 - 4.0f,
                                     11.0f,
                                     8.0f);
    tickImageView.backgroundColor = [UIColor orangeColor];
    [self addSubview:tickImageView];
    self.tickImageView = tickImageView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
