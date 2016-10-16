//
//  YZTH5WebViewController.m
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTH5WebViewController.h"

@interface YZTH5WebViewController ()<UIWebViewDelegate, H5SsoLoginDelegate>

@property (nonatomic, assign) CGFloat keyboardHeight;

@property (nonatomic, strong) H5SsoLogin *ssoLogin;

@property (nonatomic, strong) H5Options *options;

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSDictionary *jsApis;

@end

@implementation YZTH5WebViewController

#pragma mark - lifeCircle

- (id)initWithOptions:(H5Options *)options delegate:(id<H5ServiceDelegate>)delegate
{
    return [self initWithOptions:options JSApis:nil delegate:delegate];
}

- (id)initWithOptions:(H5Options *)options JSApis:(NSDictionary *)jsApis delegate:(id<H5ServiceDelegate>)delegate
{
    if (self = [super init]) {
        
//        [self setupUA];
        [self initWebView];
        // webview实例计数，用于dealloc注销免登判断
//        if (!webControllerCount) {
//            webControllerCount = 0;
//        }
//        webControllerCount++;
//        
//        self.pay = [[H5TradePay alloc] init];
//        self.contact = [[H5Contact alloc] init];
//        self.sms = [[H5Sms alloc] init];
//        self.delayExecList = [NSMutableArray array];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(safepayDidStartWithNotification:)
//                                                     name:kSafePayDidStart
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(safepayDidFinishWithNotification:)
//                                                     name:kSafePayDidFinish
//                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        
        //添加了webview domain label后，setAutomaticallyAdjustsScrollViewInsets将不再有效
        //        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        //            [self performSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:) withObject:@(NO)];
        //        }
        
        // 免登
        self.ssoLogin = [[H5SsoLogin alloc] init];
        __weak YZTH5WebViewController *weakSelf = self;
        
//        options = [self mergeURLParamsToOptions:options];
        
        // 如果是启动amr业务包，地址为file://协议
        if ([options.url hasPrefix:@"/"]) {
            self.url = [NSURL fileURLWithPath:options.url];
        } else {
            self.url = [NSURL URLWithString:options.url];
        }
        self.options = options;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.options.url]]];
//        self.toolbarHeight = TOOLBAR_HEIGHT;
//        self.titlebarHeight = TITLEBAR_HEIGHT;
        
        self.jsApis = [jsApis mutableCopy];
        self.serviceDelegate = delegate;
        
//        [self buildWebView];
        [self initJsBridge];
//        [self initWebView];
        
//        self.isInit = YES;
    }
    return self;
}

- (void)initWebView{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
}

- (void)initJsBridge{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark- UI

- (void)webViewUILoaded{
    if (!self.hasWebViewInit) {
        self.hasWebViewInit = YES;
        [self adjustWebviewContentInsets];
    }
}
- (void)updateUI{
    
}

- (void)adjustWebviewContentInsets{
//    //标题栏
//    if (H5ServiceIOSClassic()) {
//        float tempHeight = 0;
//        CGRect viewFrame = self.view.bounds;
//        if(self.options.showToolBar){
//            tempHeight += TOOLBAR_HEIGHT;
//            self.toolbar.frame = CGRectMake(0, viewFrame.size.height - tempHeight, viewFrame.size.width, TOOLBAR_HEIGHT);
//            self.fontBar.frame = CGRectMake(0, viewFrame.size.height - tempHeight + TOOLBAR_HEIGHT, viewFrame.size.width, viewFrame.size.height);
//            
//        }
//        self.webView.frame = CGRectMake(viewFrame.origin.x , viewFrame.origin.y ,
//                                        viewFrame.size.width , viewFrame.size.height - tempHeight);
//        
//    }else{
//        float top = 20;
//        float bottom = 0;
//        CGRect labelRect = self.webviewDomainLabel.frame;
//        if(self.options.showTitleBar){
//            top = 20 + TITLEBAR_HEIGHT;
//        }
//        if(self.options.showToolBar){
//            bottom = TOOLBAR_HEIGHT;
//        }
//        if(keyboardHeight > 0){
//            //键盘弹出
//            //scrollview内容超过键盘高度
//            if(self.webView.scrollView.contentSize.height > keyboardHeight){
//                bottom = keyboardHeight;
//            }else{
//                bottom = keyboardHeight - 20;
//            }
//        }
//        CGRect frame = self.view.bounds;
//        frame.origin.y = top;
//        frame.size.height -= top + bottom;
//        self.webView.frame = frame;
//        //		if(self.isWebViewInit){
//        //			self.webView.scrollView.contentInset = self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
//        //		}else{
//        //			self.webView.scrollView.contentInset = self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, 0, 0);
//        //		}
//        
//        self.webviewDomainLabel.frame = CGRectMake(0, /*top + */10, labelRect.size.width, labelRect.size.height);
//    }
//    //工具栏
}

#pragma mark - UIWebViewdelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self webViewUILoaded];
    //加载完成后重置label内容
//    [self resetWebviewDomainLabelText:webView.request.URL];
//    self.webviewDomainLabel.hidden = NO;
    //
    [self updateUI];
    NSString *pageTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.showH5TitleAuto && pageTitle.length) {
        self.title = pageTitle;
    }
    [self.webView changeH5textFont:self.fontScale];
    
    if (self.serviceDelegate &&
        [self.serviceDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.serviceDelegate webViewDidFinishLoad:webView];
    }
    self.webPageLoadSuccess = YES;
}

#pragma mark - H5SsoLoginDelegate
//sso开始登陆
- (void)H5SsoLoginDidStartLogin{
    
}
//sso登陆成功
- (void)H5SsoLoginDidEndLogin{
    
}

#pragma mark - 键盘事件

- (void)keyboardWillShow:(NSNotification *)noti{
    self.keyboardHeight = getKeyboardSize(noti).height;
    //先保存，键盘关闭后还原
}

- (void)keyboardWillHide:(NSNotification *)noti{
    self.keyboardHeight = 0;
}

- (void)keyboardDidShow:(NSNotification *)noti{
    
}

- (void)keyboardDidHide:(NSNotification *)noti{
    
}

CGSize getKeyboardSize(id sender){
    NSDictionary * info = [sender userInfo];
    NSValue * value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    return keyboardSize;
}

@end







