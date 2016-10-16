//
//  ViewController.h
//  1120混合开发
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol WebViewJSDelegate <JSExport>

JSExportAs(callPay, \
           - (void)pay:(CGFloat)money);

@end

//WebViewJavascriptBridge

@interface ViewController : UIViewController


@end

