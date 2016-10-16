//
//  CommentCell.m
//  FoodStore
//
//  Created by ZhangShouC on 2/4/15.
//  Copyright (c) 2015 liuguopan. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _count = 4;
        [self initView];
    }
    return self;
}
- (void)initView
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 20)];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_nameLabel];
    
    for (int i = 0; i < 5; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(150+25*i, 5, 20, 20);
        button.tag = i+1;
        [button setImage:[UIImage imageNamed:(i < 4 ? @"star_selected" : @"star_unselected")] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
- (void)starClick:(UIButton *)button
{
    [self setStar:button.tag];
    [_delegate starClick:_indexPath index:button.tag];
}
- (void)setStar:(NSInteger)index
{
    if (_count == index) {
        return;
    }
    _count = index;
    for (int i = 1; i <= index; i++) {
        UIButton * btn = (UIButton *)[self viewWithTag:index];
        [btn setImage:[UIImage imageNamed:@"star_selected"] forState:UIControlStateNormal];
    }
    for (int i = index +1 ; i <= 5; i++) {
        UIButton * btn = (UIButton *)[self viewWithTag:index];
        [btn setImage:[UIImage imageNamed:@"star_unselected"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
