//
//  YZTLoginModuleManager.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTLoginModuleManager.h"
#import "FirstLoginViewController.h"

@interface YZTLoginModuleManager()

@property (nonatomic, strong) UINavigationController *loginNavigationController;

@end

static YZTLoginModuleManager *sharedObj  = nil;

@implementation YZTLoginModuleManager

+ (YZTLoginModuleManager *)share{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObj = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomeThingAfterLogin) name:@"" object:nil];
    });
    return sharedObj;
}

- (void)yzt_loginFromController:(BaseViewController *)loginFromCtrl controllerChain:(NSArray<NSString *>*)controllers{
    self.homepageRequestFinishedCount = 0;
    [loginFromCtrl.tabBarController presentViewController:self.loginNavigationController animated:YES completion:^{
    }];
}

- (UINavigationController *)loginNavigationController{
    return [[UINavigationController alloc] initWithRootViewController:[FirstLoginViewController new]];
}

- (void)doSomeThingAfterLogin{
    NSLog(@"登陆完成开始做事了");
}

- (void)yzt_oneHomepageFinishRequest{
    self.homepageRequestFinishedCount ++;
}

- (void)addTaskAfterLogin:(AfterLoginCallBack)task{
    if (!_taskContainer) {
        _taskContainer = [NSMutableDictionary dictionary];
    }
    NSInteger count = _taskContainer.count;
    NSString *identifer = [NSString stringWithFormat:@"%li", count];
    _taskContainer[identifer] = [task copy];
}

- (void)doTask{
    if (_taskContainer) {
        for (NSString *key in _taskContainer.allKeys) {
            AfterLoginCallBack aTask = _taskContainer[key];
            [_taskContainer removeObjectForKey:key];
            aTask();
        }
    }
}


@end







