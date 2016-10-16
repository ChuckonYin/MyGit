//
//  H5Service.m
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "H5Service.h"

@implementation H5Service

- (BOOL)serviceEventDidComeWithController:(YZTH5WebViewController *)context event:(H5ServiceEventEnum)event
{
    
    return YES;
}

- (BOOL)serviceSeedingEventDidComeWithController:(YZTH5WebViewController *)context
                                           event:(H5ServiceSeedingEnum)event
                                       paramDict:(NSDictionary *)paramDict{
    return YES;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


@end
