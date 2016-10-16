//
//  CYCell.h
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CYCellDelegate <NSObject>

-(void)CYCellTouchWithEvent:(NSSet<UITouch *> *)touches;

@end

@interface CYCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imv;


@property (nonatomic, assign) id<CYCellDelegate>delegate;

@end
