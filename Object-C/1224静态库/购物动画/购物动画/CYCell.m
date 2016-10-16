//
//  CYCell.m
//  购物动画
//
//  Created by ChuckonYin on 15/12/27.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYCell.h"

@implementation CYCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _btn = [[UIButton alloc] initWithFrame:btnFrame];
        [_btn setImage:UIImageNamed(@"333.jpg") forState:UIControlStateNormal];
        [self addSubview:_btn];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnImg = [_btn.layer imageShotAllLayer];
    }
    return self;
}

- (void)btnClick:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(cyCellBtnClick:image:indexPath:)]) {
        [_delegate cyCellBtnClick:_btn image:_btnImg indexPath:_indexPath];
    }
}


@end
