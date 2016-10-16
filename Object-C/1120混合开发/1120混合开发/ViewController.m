//
//  ViewController.m
//  1120混合开发
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString isEqualToString:@"pay"]) {
        [self pay];
        return NO;
    }
    return YES;
}

- (void)pay{
    NSLog(@"native应用开始付款");
}


@end
