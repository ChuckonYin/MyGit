//
//  H5SsoLogin.h
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol H5SsoLoginDelegate <NSObject>

- (void)H5SsoLoginDidStartLogin;

- (void)H5SsoLoginDidEndLogin;

@end


@interface H5SsoLogin : NSObject

@property (nonatomic, weak) id<H5SsoLoginDelegate> delegate;

@end
