//
//  H5ServiceDelegate.m
//  h5test
//
//  Created by ChuckonYin on 16/5/11.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "H5ServiceDelegate.h"

@interface H5ServiceDelegate ()

@end

@implementation H5ServiceDelegate

- (BOOL)jsCallCommonNativeMethod:(NSString *)methodName{
    //
    if ([methodName isEqualToString:@"method1"]) {
        NSLog(@"处理一个业务无关的事件");
    }
    else if ([methodName isEqualToString:@"method2"]){
        NSLog(@"处理一个业务无关的事件");
    }
    return NO;
}

- (void)method1{
    
}

- (void)method2{
    
}

- (BOOL)jsCallNormalNativeMethod:(NSString *)methodName{
    [self jsCallCommonNativeMethod:methodName];
    //子类实现
    return NO;
}

@end
