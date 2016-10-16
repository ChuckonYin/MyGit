//
//  UIApplication+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define chineseFont(f) [UIFont systemFontOfSize:f]

#define NSLogDetail(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format),##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

@interface UIApplication (CYAdd)

@end
