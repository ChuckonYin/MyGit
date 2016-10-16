//
//  YZTH5WebViewController.h
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "H5Service.h"
#import "UIWebView+help.h"
#import "H5Options.h"
#import "H5SsoLogin.h"

@protocol H5ServiceDelegate;

@interface YZTH5WebViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, assign) BOOL hasWebViewInit;

@property (nonatomic, assign) BOOL showH5TitleAuto;

@property (nonatomic, copy) NSString *fontScale;

@property (nonatomic, copy) NSString *htmlZoomValue;
//web加载成功与否
@property (nonatomic, assign) BOOL webPageLoadSuccess;

@property (nonatomic, weak) id<H5ServiceDelegate> serviceDelegate;

- (id)initWithOptions:(H5Options *)options delegate:(id<H5ServiceDelegate>)delegate;

- (id)initWithOptions:(H5Options *)options JSApis:(NSDictionary *)jsApis delegate:(id<H5ServiceDelegate>)delegate;

@end
