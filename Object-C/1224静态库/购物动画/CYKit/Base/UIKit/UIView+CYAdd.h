//
//  UIView+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (CYAdd)
//instead of tag easy read
@property (nonatomic, copy, setter=setViewIdentifer:) NSString *identifier;
//set or get frame percentage
@property (nonatomic, assign) CGRect pFrame;

@property (nonatomic, strong, readwrite) UIImage *image;

@property (nonatomic, assign) CGFloat clipCornerRadius;

- (void)removeAllSubviews;
- (void)removeAllSubviewsWithoutTag:(NSInteger)tag;
- (void)removeAllSubviewsWithoutIdentifier:(NSString*)identifier;

#pragma mark - layout
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x, y, right, bottom;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width, height, centerX, centerY;

@end





