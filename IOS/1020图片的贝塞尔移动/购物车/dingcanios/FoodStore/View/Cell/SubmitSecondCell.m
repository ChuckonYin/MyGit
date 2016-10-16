//
//  SubmitSecondCell.m
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "SubmitSecondCell.h"

@interface SubmitSecondCell ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation SubmitSecondCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        [self createBackgroundView];
        [self createTotalLabel];
    }
    return self;
}

- (void)createBackgroundView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(5.0f, 4.0f, SCREEN_WIDTH - 5.0f - 5.0f, 43.0f);
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    self.bgView = bgView;
}

- (void)createTotalLabel
{
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.frame = CGRectMake(self.bgView.frame.size.width - 100.0f - 10.0f, 0, 100.0f, 43.0f);
    totalLabel.backgroundColor = [UIColor clearColor];
    totalLabel.text = @"$18.00";
    totalLabel.textColor = [UIColor colorWithRed:0.73f green:0.00f blue:0.00f alpha:1.00f];
    totalLabel.textAlignment = NSTextAlignmentRight;
    totalLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.bgView addSubview:totalLabel];
    self.totalLabel = totalLabel;
    
    UILabel *totalTitleLabel = [[UILabel alloc] init];
    totalTitleLabel.frame = CGRectMake(10.0f, 0, 100.0f, 43.0f);
    totalTitleLabel.backgroundColor = [UIColor clearColor];
    totalTitleLabel.text = @"应付总额";
    totalTitleLabel.textColor = [UIColor colorWithRed:0.73f green:0.00f blue:0.00f alpha:1.00f];
    totalTitleLabel.font = [UIFont systemFontOfSize:17.0f];
    [self.bgView addSubview:totalTitleLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
