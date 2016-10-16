//
//  MyOrderCell.m
//  FoodStore
//
//  Created by ZhangShouC on 12/31/14.
//  Copyright (c) 2014 viewcreator3d. All rights reserved.
//

#import "MyOrderCell.h"

@implementation MyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}
- (void)initView
{
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 44)];
    lab1.text = @"订单号:";
    lab1.font = [UIFont systemFontOfSize:14];
    [self addSubview:lab1];
    
    _number = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 120, 44)];
    _number.text = @"GXK138036";
    _number.font = [UIFont systemFontOfSize:14];
    _number.numberOfLines = 2;
    _number.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_number];
//
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 65, 44)];
    lab2.text = @"订单状态:";
    lab2.font = [UIFont systemFontOfSize:14];
    [self addSubview:lab2];
    
    _state = [[UILabel alloc] initWithFrame:CGRectMake(255, 0, 55, 44)];
    _state.text = @"待付款";
    _state.font = [UIFont systemFontOfSize:14];
    [self addSubview:_state];
    
////
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, 44, 300, 1)];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:line];
////
    UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 70, 25)];
    lab3.text = @"订餐时间 :";
    lab3.font = [UIFont systemFontOfSize:14];
    [self addSubview:lab3];

    _time = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 200, 25)];
    _time.text = @"2014-12-21 11:00";
    _time.font = [UIFont systemFontOfSize:14];
    [self addSubview:_time];
//    
    UILabel * lab4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 75, 70, 25)];
    lab4.text = @"餐厅名称 :";
    lab4.font = [UIFont systemFontOfSize:14];
    [self addSubview:lab4];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(80, 75, 200, 25)];
    _name.text = @"桂林米粉";
    _name.font = [UIFont systemFontOfSize:14];
    [self addSubview:_name];
//
    UILabel * lab5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, 60, 35)];
    lab5.text = @"金额 :";
    lab5.font = [UIFont systemFontOfSize:18];
//    lab5.backgroundColor = [UIColor redColor];
    [self addSubview:lab5];
    
    _price = [[UILabel alloc] initWithFrame:CGRectMake(70, 105, 80, 35)];
    _price.text = @"¥30.0";
    _price.font = [UIFont systemFontOfSize:18];
    _price.textColor = [UIColor blueColor];
//    _price.backgroundColor = [UIColor orangeColor];
    [self addSubview:_price];
    
    _action = [UIButton buttonWithType:UIButtonTypeCustom];
    _action.frame = CGRectMake(180, 105, 120, 35);
    _action.backgroundColor = [UIColor orangeColor];
    [_action setTitle:@"立即支付" forState:UIControlStateNormal];
    [_action addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    _action.layer.cornerRadius = 5;
    [self addSubview:_action];
}
- (void)click
{
    [_delegate actionClick:_indexPath];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
