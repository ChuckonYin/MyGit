//
//  VCOrdersView.m
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "VCOrdersView.h"
#import "Model.h"

#define kOrderViewWidth SCREEN_WIDTH - 10.0f

@implementation VCOrdersView

- (void)setResourceArray:(NSArray *)resourceArray
{
    if ([NSArray availableArray:resourceArray countNotZero:YES]) {
        self.frame = CGRectMake(0, 0, kOrderViewWidth, 30.0f * resourceArray.count);
        for (int i = 0; i < resourceArray.count; i++) {
            OrderInfo *order = ((OrderInfo *)[resourceArray objectAtIndex:i]);
            
            UILabel *foodNameLabel = [[UILabel alloc] init];
            foodNameLabel.frame = CGRectMake(8.0f, 30.0f * i, 210.0f, 30.0f);
            foodNameLabel.backgroundColor = [UIColor clearColor];
            foodNameLabel.text = order.foodName;
            foodNameLabel.font = [UIFont systemFontOfSize:15.0f];
            [self.superview addSubview:foodNameLabel];
            
            UILabel *priceLabel = [[UILabel alloc] init];
            priceLabel.frame = CGRectMake(kOrderViewWidth - 60.0f, 30.0f * i, 60.0f, 30.0f);
            priceLabel.backgroundColor = [UIColor clearColor];
            priceLabel.text = [NSString stringWithFormat:@"$%.2f", order.price];
            priceLabel.textColor = [UIColor colorWithRed:0.87f green:0.36f blue:0.00f alpha:1.00f];
            priceLabel.textAlignment = NSTextAlignmentCenter;
            priceLabel.font = [UIFont systemFontOfSize:14.0f];
            [self.superview addSubview:priceLabel];
            
            UILabel *copiesLabel = [[UILabel alloc] init];
            copiesLabel.frame = CGRectMake(kOrderViewWidth - 60.0f - 30.0f, 30.0f * i, 30.0f, 30.0f);
            copiesLabel.backgroundColor = [UIColor clearColor];
            copiesLabel.text = [NSString stringWithFormat:@"%d", order.copies];
            copiesLabel.textAlignment = NSTextAlignmentCenter;
            copiesLabel.font = [UIFont systemFontOfSize:14.0f];
            [self.superview addSubview:copiesLabel];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
