//
//  CYCell.m
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYCell.h"

@implementation CYCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self addSubview:_imv];
        _imv.backgroundColor = [UIColor lightGrayColor];
        _imv.image = [UIImage imageNamed:@"Star 1"];
        [_imv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(act)]];
    }
    return self;
}
-(void)act{
    NSLog(@"act");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_imv.frame, p)) {
        return;
    }
    NSLog(@"fsdafasfdas%");
    [_delegate CYCellTouchWithEvent:touches];
}

@end
