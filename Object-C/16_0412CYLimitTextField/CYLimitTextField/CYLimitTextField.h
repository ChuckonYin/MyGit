//
//  CYLimitTextField.h
//  CYLimitTextField
//
//  Created by ChuckonYin on 16/4/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYLimitTextField : UITextField

@property (nonatomic, assign) id delegate;

/**
 *  @param frame
 *  @param limitType ### ### ###
 *  @return
 */

- (instancetype)initWithFrame:(CGRect)frame limit:(NSString *)limitString preferDirection:(BOOL)rightToleft;

@end
