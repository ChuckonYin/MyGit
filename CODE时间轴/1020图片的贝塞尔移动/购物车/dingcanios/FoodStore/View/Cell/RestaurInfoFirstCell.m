//
//  RestaurInfoFirstCell.m
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "RestaurInfoFirstCell.h"
#import "VCSeparotorView.h"
#import "VCStarsImageView.h"

@interface RestaurInfoFirstCell ()

@property (nonatomic, strong) VCStarsImageView *starsView;

@end

@implementation RestaurInfoFirstCell

- (void)awakeFromNib {
    // Initialization code
    
    UIView *view = [self.contentView viewWithTag:10000];
    if ([view isKindOfClass:[VCSeparotorView class]]) {
        ((VCSeparotorView *)view).onlyOneLine = NO;
    }
    
    VCStarsImageView *starsView = [[VCStarsImageView alloc] init];
    starsView.frame = CGRectMake(50.0f, 30.0f, 75.0f, 15.0f);
    [self.contentView addSubview:starsView];
    self.starsView = starsView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
