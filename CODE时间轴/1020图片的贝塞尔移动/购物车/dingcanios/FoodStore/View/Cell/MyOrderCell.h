//
//  MyOrderCell.h
//  FoodStore
//
//  Created by ZhangShouC on 12/31/14.
//  Copyright (c) 2014 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyOrderCellDelegate <NSObject>

- (void)actionClick:(NSIndexPath *)indexPath;

@end

@interface MyOrderCell : UITableViewCell

@property (nonatomic,strong) UILabel * number;
@property (nonatomic,strong) UILabel * state;
@property (nonatomic,strong) UILabel * time;
@property (nonatomic,strong) UILabel * name;
@property (nonatomic,strong) UILabel * price;
@property (nonatomic,strong) UIButton * action;
@property (nonatomic) NSIndexPath * indexPath;

@property (nonatomic,weak) __weak id<MyOrderCellDelegate> delegate;

@end

