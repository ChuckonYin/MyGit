//
//  UIWebView+help.m
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "UIWebView+help.h"

@implementation UIWebView (help)
//获取页面zoom值
- (NSString *)htmlZoomValue{
    return [self stringByEvaluatingJavaScriptFromString:@"parseFloat(document.defaultView.getComputedStyle(document.documentElement).getPropertyValue('zoom'))*parseFloat(document.defaultView.getComputedStyle(document.body).getPropertyValue('zoom'))"];
}

- (BOOL)changeH5textFont:(NSString *)fontSize{
    // 如果zoom不等1，说明页面使用了zoom，那就不响应调整字体大小功能
    if([self.htmlZoomValue isEqualToString:@"1"] && fontSize.length > 0){
        NSString *jsCode = [NSString stringWithFormat:@"document.body.style.webkitTextSizeAdjust = '%@'", fontSize];
        [self stringByEvaluatingJavaScriptFromString:jsCode];
        return YES;
    }
    return NO;
}

@end
