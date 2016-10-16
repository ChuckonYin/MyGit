//
//  YZTPopButtun.h
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/5/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTPopMenu : UIView

+ (YZTPopMenu *)yzt_showOnView:(UIView *)superView
       topLocation:(CGPoint)topLocation
                titles:(NSArray<NSString*>*)titles
                images:(NSArray<NSString*>*)images
         horizontalOff:(CGFloat)off
          selectAction:(void(^)(NSInteger))selectAction;

- (void)yzt_dismiss;

@end
