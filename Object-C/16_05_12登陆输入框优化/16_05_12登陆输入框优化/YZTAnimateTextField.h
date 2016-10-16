//
//  YZTAnimateTextField.h
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTAnimateTextField : UIView

/// default 0.8
@property (nonatomic, assign) CGFloat topPlaceholderScale;
/// default size 16
@property (nonatomic, strong) UIFont *normalPlaceholderFont;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) id<UITextFieldDelegate> delegate;

- (instancetype)initWithNormalPlaceholder:(NSString *)normalPlaceholder
                                 delegate:(id<UITextFieldDelegate>)delegate;

@end
