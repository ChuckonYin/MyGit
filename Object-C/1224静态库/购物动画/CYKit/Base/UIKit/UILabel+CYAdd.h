//
//  UILabel+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CYAdd)

@property (nonatomic, copy, readonly) UILabel*(^frame_)(CGRect);
@property (nonatomic, copy, readonly) UILabel*(^text_)(NSString*);
@property (nonatomic, copy, readonly) UILabel*(^bgColor_)(UIColor*);
@property (nonatomic, copy, readonly) UILabel*(^font_)(UIFont*);
@property (nonatomic, copy, readonly) UILabel*(^textAlig_)(NSTextAlignment);
@property (nonatomic, copy, readonly) UILabel*(^textColor_)(UIColor*);

- (void)setText:(id)text textColor:(UIColor*)textColor fontSize:(CGFloat)size textAlig:(NSTextAlignment)alig bgColor:(UIColor*)bgColor;

@end
