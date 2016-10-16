//
//  H5WebViewController.m
//  h5test
//
//  Created by ChuckonYin on 16/5/11.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "H5WebViewController.h"
#import "H5ServiceDelegate.h"

@interface H5WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) H5ServiceDelegate *delegate;

@end

@implementation H5WebViewController

- (id)initWithUrl:(id) url delegate:(H5ServiceDelegate *)delegate{
    self = [super init];
    _delegate = delegate;
    self.webView.delegate = self;
    return self;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //目前有些截取方法不一致，尽量统一
    if (self.delegate && [self.delegate respondsToSelector:@selector(jsCallNormalNativeMethod:)]) {
        return [self.delegate jsCallNormalNativeMethod:@"oneNormalMethodName"];
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
