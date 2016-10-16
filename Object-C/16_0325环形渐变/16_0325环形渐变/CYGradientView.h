//
//  CYGradientView.h
//  16_0325环形渐变
//
//  Created by ChuckonYin on 16/3/25.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CYGradientType){
    CYGradientTypeRadius,
    CYGradientTypeLine
};

@interface CYGradientView : UIView


static inline void drawGradientRadial();

@end

//@interface CYGradientColor: NSObject

//@property (nonatomic, assign, readonly) CGFloat red, green, blue;
//
//+ (id)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
//
//@end




