//
//  WealthHealthCell.h
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WealthHealthModel.h"

@protocol WealthHealthCellDelegate <NSObject>

- (void)wealthHealthCellClick:(NSInteger)index;

@end

@interface WealthHealthCell : UITableViewCell

@property (nonatomic, strong) WealthHealthModel *model;

@property (nonatomic, weak) id<WealthHealthCellDelegate> delegate;

@end
