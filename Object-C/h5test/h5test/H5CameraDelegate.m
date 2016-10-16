//
//  H5CameraDelegate.m
//  h5test
//
//  Created by ChuckonYin on 16/5/11.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "H5CameraDelegate.h"

@interface H5CameraDelegate ()

@end

@implementation H5CameraDelegate

- (BOOL)jsCallNormalNativeMethod:(NSString *)methodName{
    [super jsCallNormalNativeMethod:methodName];
    NSLog(@"处理一个业务相关的事件");
    return NO;
}

@end
