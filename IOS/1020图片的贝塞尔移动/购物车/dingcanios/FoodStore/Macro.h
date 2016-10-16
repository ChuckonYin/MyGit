//
//  Macro.h
//  FoodStore
//
//  Created by liuguopan on 14-12-8.
//  Copyright (c) 2014年 liuguopan. All rights reserved.
//

/**
 *  定义常用的宏
 *  比如：系统版本，视图坐标，控制打印日志
 */
#ifndef FoodStore_Macro_h
#define FoodStore_Macro_h

/**
 *  iOS系统版本号
 */
#define IOS_VERSION             ([[UIDevice currentDevice].systemVersion floatValue])

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)

/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)

/**
 *  ViewController的view宽度
 */
#define SELF_VIEW_WIDTH         (self.view.frame.size.width)

/**
 *  ViewController的view高度
 */
#define SELF_VIEW_HEIGHT        (self.view.frame.size.height)

/**
 *  当前view的宽
 */
#define SELF_WIDTH              (self.frame.size.width)

/**
 *  当前view的高
 */
#define SELF_HEIGHT             (self.frame.size.height)

/**
 *  状态栏高度
 */
#define STATUSBAR_HEIGHT        20.0f

/**
 *  导航栏高度
 */
#define NAVIGATIONBAR_HEIGHT    44.0f

/**
 *  状态栏和导航栏高度之和
 */
#define STATUS_NAV_BAR_HEIGHT   (STATUSBAR_HEIGHT + NAVIGATIONBAR_HEIGHT)

/**
 *  iOS6->iOS7坐标改变，7屏幕左上角为(0, 0)
 */
#define IS_20_IOS7              ((IOS_VERSION < 7.0 ) ? 0 : 20.0f)

/**
 *  self.view.frame.origin.y的起点坐标
 */
#define SELF_VIEW_ORIGIN_Y      (NAVIGATIONBAR_HEIGHT + IS_20_IOS7)

/**
 *  view的高
 */
#define VIEW_HEIGHT(view)       (view.frame.size.height)

/**
 *  view的宽
 */
#define VIEW_WIDTH(view)        (view.frame.size.width)


/********** 网络  **********/
#define NetworkMonitor_Host     @"www.baidu.com"
#define Public_Network_Change   @"PublicNetworkChange"

//网络判断
enum {
    NotNetworkStatu = 0,    //没有网络
    NetworkisWWAN,          //2G、3G网络
    NetworkisWiFi,          //wifi网络 (可联通广域网)
    NetworkisLAN            //wifi网络 (不可连通广域网)
};
typedef	uint32_t NetworkStatusType;


//  转换含有汉字的url
#define URL_STRING_ENCODE(string) (NSString *)CFBridgingRelease\
(CFURLCreateStringByAddingPercentEscapes\
(kCFAllocatorDefault,\
(CFStringRef)(string),\
NULL,\
NULL,\
kCFStringEncodingUTF8))


/**
 *  tag值的下限（给View赋tag值时，使用TAG_MIN + x）
 */
#define TAG_MIN                 1000

/********** 控制打印日志  **********/

#ifdef DEBUG    //  DEBUG模式
#define LOG_METHOD              NSLog(@"\n%s\n\n", __func__)
#define LOG(content)            NSLog(@"\n\n%@\n\n", content)
#define LOG_FORMAT(format, ...) NSLog(@"\n\n"format@"\n\n", ##__VA_ARGS__)
#define LOG_NAME(name, content) NSLog(@"\n\n%@\n%@\n\n", name, content)
#else           //  Release模式
#define LOG_METHOD
#define LOG(content)
#define LOG_FORMAT(format, ...)
#define LOG_NAME(name, content)
#endif


#define LIUGUOPAN               0
#define ZHANGSHOUCHENG          0

#ifdef DEBUG
#define TEST                    1
#else
#define TEST                    0
#endif

#endif
