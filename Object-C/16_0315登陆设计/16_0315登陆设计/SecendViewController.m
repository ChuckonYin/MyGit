//
//  SecendViewController.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "SecendViewController.h"
#import "FirstLoginViewController.h"
#import "YZTLoginModuleManager.h"
#import "ViewController.h"

const NSString *sss = @"fsdfsf";

@interface SecendViewController ()

@end

@implementation SecendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self yzt_viewDiLoad];
}

- (void)yzt_viewDiLoad{
    
    int i = 0;
    NSLog(@"%", i);
    NSLog(@"%p", sss);
    NSString *s = @"fsds";
     NSLog(@"%p", self);
    self.title = @"web页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = self.navigationController.viewControllers;
    BaseViewController *vc = arr[0];
    __unsafe_unretained SecendViewController *weakSelf = self;
    [[YZTLoginModuleManager share] yzt_registerTaskAfterLogin:^{
        weakSelf.view.backgroundColor = [UIColor whiteColor];
    }];
    __block int qq = 2;
    AfterLoginCallBack b = ^{
        qq=0;
    };
    NSLog(@"%li", CFGetRetainCount((__bridge CFTypeRef)b));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![YZTLoginModuleManager share].hasLoginSucess) {
         [[YZTLoginModuleManager share] yzt_loginFromController:self controllerChain:@[@"", @""]];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

@end
