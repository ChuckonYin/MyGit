//
//  YZTLoginModuleManager.h
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

typedef void(^AfterLoginCallBack)();

@interface YZTLoginModuleManager : NSObject

+ (YZTLoginModuleManager *)share;

@property (nonatomic, assign) BOOL hasLoginSucess;

@property (nonatomic, strong) NSArray <NSString *>* controllers;

@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) NSMutableDictionary *taskContainer;
/**
 *  标签栏数据加载完毕
 */
@property (nonatomic, assign) NSInteger homepageRequestFinishedCount;

- (void)yzt_oneHomepageFinishRequest;

/**
 *
 *  @param loginFromCtrl
 *  @param controllers
 */
- (void)yzt_loginFromController:(BaseViewController *)loginFromCtrl controllerChain:(NSArray<NSString *>*)controllers;

- (void)addTaskAfterLogin:(AfterLoginCallBack)task;

@end
