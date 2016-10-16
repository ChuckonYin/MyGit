//
//  FirstLoginViewController.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "SecondLoginViewController.h"

@interface FirstLoginViewController ()

@end

@implementation FirstLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆页面1";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarItemAction)];
}

- (void)rightBarItemAction{
    [self.navigationController pushViewController:[SecondLoginViewController new] animated:YES];
}


@end
