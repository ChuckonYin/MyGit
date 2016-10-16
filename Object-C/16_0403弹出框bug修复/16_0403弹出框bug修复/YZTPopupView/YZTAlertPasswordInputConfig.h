//
//  YZTAlertInputPassword.h
//  PANewToapAPP
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZTAlertView.h"
#import "YZTPopViewFactory.h"

@interface YZTAlertPasswordInputConfig : NSObject

- (YZTAlertView *)configAlertPasswordViewWithTitle:(NSString *)title
                                         pwdLength:(NSInteger)length
                                        itemTitles:(NSArray *)itemTitles
                                         itemTypes:(NSArray *)itemTypes
                                           handler:(YZTPopAlertInputHandler)handler;

@end


@interface YZTBlackPointView : UIView

@property (nonatomic, strong) UIView *blackPointView;

- (void)hideBlackPoint:(BOOL)isHide;

@end