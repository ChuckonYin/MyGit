//
//  UIWebView+help.h
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (help)

@property (nonatomic, copy, readonly) NSString *htmlZoomValue;

- (BOOL)changeH5textFont:(NSString *)fontSize;

@end
