//
//  YZTTitleImageButtun.m
//  16_0224
//
//  Created by ChuckonYin on 16/2/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTTitleImageButtun.h"

@interface YZTTitleImageButtun()

@property (nonatomic, assign) CGFloat cy_x, cy_y, cy_width, cy_height;

@property (nonatomic, assign, readonly) CGRect titleRect;

@property (nonatomic, assign, readonly) CGRect imageRect;

@end

@implementation YZTTitleImageButtun

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectIsEmpty(_titleRect) ? self.bounds : _titleRect;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (_isImageHidden) {
        return CGRectZero;
    }
    return CGRectIsEmpty(_imageRect) ? self.bounds : _imageRect;
}
- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets{
    _titleRect = CGRectMake(titleEdgeInsets.left, titleEdgeInsets.top, self.cy_width - titleEdgeInsets.left - titleEdgeInsets.right, self.cy_height - titleEdgeInsets.top - titleEdgeInsets.bottom);
    NSLog(@"%@", [NSValue valueWithCGRect:_titleRect]);
    [super setNeedsDisplay];
}
- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets{
    _imageRect = CGRectMake(imageEdgeInsets.left, imageEdgeInsets.top, self.cy_width - imageEdgeInsets.left - imageEdgeInsets.right, self.cy_height - imageEdgeInsets.top - imageEdgeInsets.bottom);
    NSLog(@"%@", [NSValue valueWithCGRect:_imageRect]);
    [super setNeedsDisplay];
}

#pragma mark - get & set

#pragma mark - private

- (CGFloat)cy_x{
    return self.frame.origin.x;
}

- (CGFloat)cy_y{
    return self.frame.origin.y;
}

- (CGFloat)cy_width{
    return self.frame.size.width;
}

- (CGFloat)cy_height{
    return self.frame.size.height;
}


@end
