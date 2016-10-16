//
//  CYAttributeLabel.h
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CYFrameData.h"

@protocol CYAttributeLabelDelegate <NSObject>
- (void)cyAttributeLabelClickIndex:(NSInteger)index link:(NSString*)url;
@end

@interface CYAttributeLabel :UIView

@property (nonatomic, assign) id<CYAttributeLabelDelegate> delegate;

//NSSting的属性
//default 5.0f
@property (nonatomic, assign) CGFloat lineSpace;
//default 0x9b9b9b
@property (nonatomic, strong) UIColor *color;

//2、可直接传入text、nsattributestring、uiimage、uiview
@property (nonatomic, strong) NSArray *objcArr;

//预算富文本高度，精准。
+ (CGFloat)heightForObjcArr:(NSArray*)objcArr withWidth:(CGFloat)width;

@end






