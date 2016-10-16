//
//  H5Service.h
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

typedef enum
{
    H5ServiceEventEnumViewDidLoad,
    H5ServiceEventEnumViewWillAppear,
    H5ServiceEventEnumViewDidAppear,
    H5ServiceEventEnumViewBack,
    H5ServiceEventEnumMax
} H5ServiceEventEnum;

typedef enum
{
    H5ServiceSeedingEnumPayServiceStart,
    H5ServiceSeedingEnumPayServiceFinish,
    H5ServiceSeedingEnumMax
} H5ServiceSeedingEnum;


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YZTH5WebViewController.h"

@class YZTH5WebViewController;
@protocol H5ServiceDelegate <NSObject>

@optional
/**
 *	外部业务层可能需要处理的消息
 *
 *	@param 	context 	（输入）上下文，一般是当前的H5ServiceWebController
 *	@param 	event       （输入）消息枚举，参见H5ServiceEventEnum定义
 *  return : YES        业务层处理了本消息，那么H5Service就不会处理
 *           NO         业务层不需要处理的消息，那么H5Service就会处理
 */
- (BOOL)serviceEventDidComeWithController:(YZTH5WebViewController *)context event:(H5ServiceEventEnum)event;

/**
 *	外部业务层可能需要处理的埋点消息
 *
 *	@param 	context 	（输入）上下文，一般是当前的H5ServiceWebController
 *	@param 	event       （输入）消息枚举，参见H5ServiceSeedingEnum定义
 *	@param 	paramDict   （输入）参数信息，定义参考http://ux.alipay-inc.com/index.php/H5%E5%AE%B9%E5%99%A8#X1._.E5.9F.8B.E7.82.B9.E6.94.AF.E6.8C.81－－X1. 埋点支持
 *          备注：paramDict[@“interceptedUrl”]为NSString对象数据
 *               paramDict[@"result"]为SPOrder/MQPResult对象数据
 *  return : YES        业务层处理了本消息，那么H5Service就不会处理
 *           NO         业务层不需要处理的消息，那么H5Service就会处理
 */
- (BOOL)serviceSeedingEventDidComeWithController:(YZTH5WebViewController *)context
                                           event:(H5ServiceSeedingEnum)event
                                       paramDict:(NSDictionary *)paramDict;

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface H5Service : NSObject<H5ServiceDelegate>

@end



















