//
//  ViewController.m
//  0113支付宝集成
//
//  Created by ChuckonYin on 16/1/13.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    *  @param appIDStr     应用ID
//    *  @param productIDStr 产品码 该商户在aboss签约的产品,用户获取pid获取的参数
//    *  @param pidStr       商户ID   可不填
//    *  @param uriStr       授权的应用回调地址  比如：alidemo://auth
    
    APayAuthInfo *info = [[APayAuthInfo alloc] initWithAppID:@"" pid:@"" redirectUri:@""];
    
    
    
    [[AlipaySDK defaultService] payOrder:[info wapDescription] fromScheme:<#(NSString *)#> callback:^(NSDictionary *resultDic) {
        
    }];
    
}


@end
