//
//  OrderCenterSecondCell.h
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCOrdersView.h"

@interface OrderCenterSecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet VCOrdersView *ordersView;
@property (weak, nonatomic) IBOutlet UILabel *taxationLabel;
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end
