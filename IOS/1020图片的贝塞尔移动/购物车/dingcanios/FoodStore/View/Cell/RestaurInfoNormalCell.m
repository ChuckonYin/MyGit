//
//  RestaurInfoNormalCell.m
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "RestaurInfoNormalCell.h"
#import "VCSeparotorView.h"

@implementation RestaurInfoNormalCell

- (void)awakeFromNib {
    // Initialization code
    
    UIView *view = [self.contentView viewWithTag:10000];
    if ([view isKindOfClass:[VCSeparotorView class]]) {
        ((VCSeparotorView *)view).onlyOneLine = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
