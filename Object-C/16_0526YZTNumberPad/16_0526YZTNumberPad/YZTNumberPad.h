//
//  YZTNumberPad.h
//  16_0526YZTNumberPad
//
//  Created by ChuckonYin on 16/5/26.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@protocol YZTNumberPadDelegate <NSObject>

- (BOOL)yztNumberPadClick:(UITextField *)textField number:(NSString *)number;

- (void)yztNumberPadClear:(UITextField *)textField;

- (BOOL)yztNumberPadConfirm:(UITextField *)textField;

- (void)yztNumberPadHide:(UITextField *)textField;

@end

@interface YZTNumberPad : UIView

@property (nonatomic, assign) id<YZTNumberPadDelegate> delegate;

- (instancetype)initWithTextField:(UITextField *)textField;

@end
