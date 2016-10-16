//
//  CYCell.h
//  购物动画
//
//  Created by ChuckonYin on 15/12/27.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define btnFrame CGRectMake(30, 30, 40, 40)

@protocol CYCellDelegate <NSObject>

- (void)cyCellBtnClick:(UIButton*)btn image:(UIImage*)img indexPath:(NSIndexPath*)indexPath;

@end

@interface CYCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIImage *btnImg;

@property (nonatomic, assign) id delegate;

@end
