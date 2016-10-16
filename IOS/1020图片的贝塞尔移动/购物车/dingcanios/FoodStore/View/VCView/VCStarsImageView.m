//
//  VCStarsImageView.m
//  FoodStore
//
//  Created by liuguopan on 15/1/16.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "VCStarsImageView.h"

@interface VCStarsImageView ()

@property (nonatomic, strong) UIView *starsView;

@end

@implementation VCStarsImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImage:[UIImage imageNamed:@"food_stars_bottom.png"]];
        [self createStarsView];
        [self createTopImageView];
    }
    return self;
}

- (void)createStarsView
{
    UIView *starsView = [[UIView alloc] init];
    starsView.frame = CGRectMake(0, 0, 75.0f, 15.0f);
    starsView.clipsToBounds = YES;
    [self addSubview:starsView];
    self.starsView = starsView;
}

- (void)createTopImageView
{
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.frame = self.starsView.bounds;
    [topImageView setImage:[UIImage imageNamed:@"food_stars_top.png"]];
    [self.starsView addSubview:topImageView];
}

- (void)setStars:(float)stars
{
    self.starsView.frame = CGRectMake(0,
                                      0,
                                      self.frame.size.width * stars / 5.0f,
                                      self.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
