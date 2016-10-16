//
//  FoodCell.m
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

- (void)awakeFromNib {
    // Initialization code
    
    VCStarsImageView *starsView = [[VCStarsImageView alloc] init];
    starsView.frame = CGRectMake(107.0f, 60.0f, 75.0f, 15.0f);
    [self.contentView addSubview:starsView];
    self.starsView = starsView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
