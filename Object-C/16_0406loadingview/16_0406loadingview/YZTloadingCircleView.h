//
//  YZTloadingView.h
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/4/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTloadingCircleView : UIView

//default 1.0
@property (nonatomic, assign) NSTimeInterval interval;

@property (nonatomic, assign) CGFloat bgCoverAlpha;

- (void)startAnimation:(NSString *)dsc;

- (void)stopAnimation;

//- (void)resetDscText:(NSString *)dsc;

@end
