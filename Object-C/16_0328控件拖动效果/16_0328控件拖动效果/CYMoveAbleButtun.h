//
//  CYMoveAbleButtun.h
//  16_0328控件拖动效果
//
//  Created by ChuckonYin on 16/3/28.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CYMoveAbleButtunDelegate <NSObject>
@optional
- (void)cy_moveAbleButtunTouchDown:(UIControl *)control withEvent:event;
- (void)cy_moveAbleButtunDragMoving:(UIControl *)c withEvent:ev;
- (void)cy_moveAbleButtunDragEnded:(UIControl *)c withEvent:ev;
@end

@interface CYMoveAbleButtun : UIButton

@property (nonatomic, weak) id<CYMoveAbleButtunDelegate> delegate;

@end
