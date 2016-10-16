//
//  CYCell.m
//  1231tabelview制作轮播控件
//
//  Created by ChuckonYin on 15/12/31.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYCell.h"
#import "ViewController.h"
@implementation CYCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [[UIScreen mainScreen] bounds].size.height)];
        _imgView.center = CGPointMake([[UIScreen mainScreen] bounds].size.height/2, screenWidth/2);
        _imgView.transform = CGAffineTransformMakeRotation(-M_PI/2);
//        _imgView.backgroundColor = [UIColor redColor];
        [self addSubview:_imgView];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
