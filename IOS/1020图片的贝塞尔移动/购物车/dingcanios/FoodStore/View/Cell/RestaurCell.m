//
//  RestaurCell.m
//  FoodStore
//
//  Created by liuguopan on 14/12/29.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "RestaurCell.h"

#define kIconAreaWidth          55.0f
#define kFavoriteButtonWidth    50.0f
#define kStarsViewWidth         45.0f

#define kMiddenWidth            SCREEN_WIDTH - kIconAreaWidth - kFavoriteButtonWidth

@interface RestaurCell ()

@property (nonatomic, strong) UIView *starsView;

@end

@implementation RestaurCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        [self createSeparatorLine];     //  分割线
        [self createIconImageView];     //  餐厅图标
        [self createFavoriteButton];    //  收藏按钮
        [self createRestaurNameLabel];  //  餐厅名字
        [self createStarsImageView];    //  星级
        [self createReviewsLabel];      //  评论数
        [self createSellCopiesLabel];   //  月售
        [self createMiddleLabels];      //  人均/运费/运送时间
        [self createBottomLabels];      //  菜系/优惠/提醒
    }
    return self;
}

- (void)createSeparatorLine
{
    CALayer *separatorLayar = [[CALayer alloc] init];
    separatorLayar.frame = CGRectMake(kIconAreaWidth, 65.0, SCREEN_WIDTH - 50.0, 0.7);
    separatorLayar.backgroundColor = [UIColor colorWithRed:0.87f green:0.87f blue:0.87f alpha:1.00f].CGColor;
    [self.layer addSublayer:separatorLayar];
}

- (void)createIconImageView
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.frame = CGRectMake((kIconAreaWidth - 40.0f) / 2 , 10.0f, 40.0f, 40.0f);
    iconImageView.backgroundColor = [UIColor orangeColor];
    [iconImageView setImage:[UIImage imageNamed:@"food_icon_temp.png"]];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
}

- (void)createFavoriteButton
{
    VCButton *favoriteButton = [VCButton buttonWithType:UIButtonTypeCustom];
    favoriteButton.frame = CGRectMake(SCREEN_WIDTH - kFavoriteButtonWidth,
                                      0,
                                      kFavoriteButtonWidth,
                                      40.0f);
    favoriteButton.backgroundColor = [UIColor whiteColor];
    [favoriteButton setImage:[UIImage imageNamed:@"restaur_favorite_unselected.png"]
                    forState:UIControlStateNormal];
    [favoriteButton setImage:[UIImage imageNamed:@"restaur_favorite_selected.png"]
                    forState:UIControlStateSelected];
    [favoriteButton setImageEdgeInsets:UIEdgeInsetsMake(12.0f, 17.0f, 15.0f, 16.0f)];
    favoriteButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:favoriteButton];
    self.favoriteButton = favoriteButton;
}

- (void)createRestaurNameLabel
{
    UILabel *restaurNameLabel = [[UILabel alloc] init];
    restaurNameLabel.frame = CGRectMake(kIconAreaWidth, 0.0f, kMiddenWidth, 25.0f);
    restaurNameLabel.backgroundColor = [UIColor clearColor];
    restaurNameLabel.text = @"桂林米粉（伦敦城店）";
    restaurNameLabel.font = [UIFont systemFontOfSize:15.0f];
    [self addSubview:restaurNameLabel];
    self.restaurNameLabel = restaurNameLabel;
}

- (void)createStarsImageView
{
    UIImageView *starsBgView = [[UIImageView alloc] init];
    starsBgView.frame = CGRectMake(kIconAreaWidth, 25.0f, kStarsViewWidth, 14);
    [starsBgView setImage:[UIImage imageNamed:@"restaur_stars_bottom.png"]];
    [self addSubview:starsBgView];
                                   
    UIView *starsView = [[UIView alloc] init];
    starsView.frame = CGRectMake(kIconAreaWidth, 25.0f, kStarsViewWidth, 14);
    starsView.backgroundColor = [UIColor clearColor];
    starsView.clipsToBounds = YES;
    [self addSubview:starsView];
    self.starsView = starsView;
    
    UIImageView *starsTopView = [[UIImageView alloc] init];
    starsTopView.frame = CGRectMake(0, 0, kStarsViewWidth, 14);
    [starsTopView setImage:[UIImage imageNamed:@"restaur_stars_top.png"]];
    [self.starsView addSubview:starsTopView];
}

- (void)createReviewsLabel
{
    UILabel *reviewLabel = [[UILabel alloc] init];
    reviewLabel.frame = CGRectMake(kIconAreaWidth + 45.0f, 25.0f, kMiddenWidth - 45.0f, 14.0f);
    reviewLabel.backgroundColor = [UIColor clearColor];
    reviewLabel.text = @"(1234)";
    reviewLabel.font = [UIFont systemFontOfSize:11.0f];
    [self addSubview:reviewLabel];
    self.reviewsLabel = reviewLabel;
}

- (void)createSellCopiesLabel
{
    UILabel *sellCopiesLabel = [[UILabel alloc] init];
    sellCopiesLabel.frame = CGRectMake(kIconAreaWidth + 100.0f, 25.0f, 80.0f, 14.0f);
    sellCopiesLabel.backgroundColor = [UIColor clearColor];
    sellCopiesLabel.text = @"月售2234份";
    sellCopiesLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:sellCopiesLabel];
    self.sellCopiesLable = sellCopiesLabel;
}

- (void)createMiddleLabels
{
    UILabel *percapitaLabel = [[UILabel alloc] init];
    percapitaLabel.frame = CGRectMake(kIconAreaWidth, 40.0f, 60.0f, 25.0f);
    percapitaLabel.backgroundColor = [UIColor clearColor];
    percapitaLabel.text = @"人均:$100.56";
    percapitaLabel.font = [UIFont systemFontOfSize:8.5f];
    [self addSubview:percapitaLabel];
    self.percapitaExpenseLabel = percapitaLabel;
    
    UILabel *freightLabel = [[UILabel alloc] init];
    freightLabel.frame = CGRectMake(kIconAreaWidth + 60.0f, 40.0f, 80.0f, 25.0f);
    freightLabel.backgroundColor = [UIColor clearColor];
    freightLabel.text = @"/  运费:$22.22pkm";
    freightLabel.font = [UIFont systemFontOfSize:8.5f];
    [self addSubview:freightLabel];
    self.freightLabel = freightLabel;
    
    UILabel *freightTimeLabel = [[UILabel alloc] init];
    freightTimeLabel.frame = CGRectMake(kIconAreaWidth + 70.0f + 70.0f, 40.0f, 90.0f, 25.0f);
    freightTimeLabel.backgroundColor = [UIColor clearColor];
    freightTimeLabel.text = @"/  256分钟";
    freightTimeLabel.font = [UIFont systemFontOfSize:8.5f];
    [self addSubview:freightTimeLabel];
    self.freightTimeLabel = freightTimeLabel;
}

- (void)createBottomLabels
{
    UILabel *cuisineLabel = [[UILabel alloc] init];
    cuisineLabel.frame = CGRectMake(kIconAreaWidth, 65.0f, 100.0f, 90.0f - 65.0f);
    cuisineLabel.backgroundColor = [UIColor clearColor];
    cuisineLabel.text = @"菜系:桂菜";
    cuisineLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:cuisineLabel];
    self.cuisineLabel = cuisineLabel;
    
    UILabel *couponTipsLabel = [[UILabel alloc] init];
    couponTipsLabel.frame = CGRectMake(kIconAreaWidth + 100.0f, 65.0f, 120.0f, 90.0f - 65.0f);
    couponTipsLabel.backgroundColor = [UIColor clearColor];
    couponTipsLabel.text = @"优惠/提醒:米饭没有了";
    couponTipsLabel.font = [UIFont systemFontOfSize:10.0f];
    [self addSubview:couponTipsLabel];
    self.couponTipsLabel = couponTipsLabel;
    
}

- (void)setStars:(float)stars
{
    self.starsView.frame = CGRectMake(kIconAreaWidth, 25.0f, kStarsViewWidth * stars / 5.0f, 14);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
