//
//  FirstViewController.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "FirstViewController.h"
#import "SecendViewController.h"
#import "YZTLoginModuleManager.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模块首页";
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarItemAction)];
    YZTLoginModuleManager *m = [YZTLoginModuleManager share];
//    [[YZTLoginModuleManager share] yzt_registerTaskAfterLogin:^{
//        self.view.backgroundColor = [UIColor whiteColor];
//    }];
    if (m.hasLoginSucess) {
        [self.navigationController pushViewController:[SecendViewController new] animated:YES];
    }
   
}

- (void)rightBarItemAction{
    [self.navigationController pushViewController:[SecendViewController new] animated:YES];
}



@end
