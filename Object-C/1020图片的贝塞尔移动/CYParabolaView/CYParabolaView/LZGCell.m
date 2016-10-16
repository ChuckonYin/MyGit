//
//  LZGCell.m
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "LZGCell.h"

@implementation LZGCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _adImg.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_adImg.frame, p)) {
        return;
    }
    NSLog(@"fsdafasfdas%");
    [_delegate CYCellTouchWithEvent:touches];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
