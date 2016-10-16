//
//  ViewController.m
//  Html
//
//  Created by yinxukun on 16/10/13.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view addSubview:self.webView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarItemAction)];
    
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"firstHtml" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webView loadRequest:request];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
            
        }
        else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }
}

- (void)rightBarItemAction{
    NSLog(@"返回");
    [self.webView evaluateJavaScript:@"window.history.back()" completionHandler:^(id _Nullable h, NSError * _Nullable error) {
        
    }];
}
    
- (void)yzt_showAction:(NSString *)str{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth, 50, kScreenWidth, 20)];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor whiteColor];
    label.text = str;
    label.textColor = [UIColor darkGrayColor];
    [UIView animateWithDuration:8 animations:^{
        label.transform = CGAffineTransformMakeTranslation(-2.0*kScreenWidth, 0);
    } completion:^(BOOL finished) {
        
    }];
}


- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(30, 100, 350, 500)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}
    
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *href = navigationAction.request.URL.absoluteString;
    if ([href containsString:@"baidu"]) {
        [self yzt_showAction:[NSString stringWithFormat:@"拦截到请求：%@", href]];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
  
    
    
@end





