//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *scroll         = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    scroll.backgroundColor = [UIColor lightGrayColor];
    
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 50, 100, 50));
    }];
    
    UIView *scrollContain  = [[UIView alloc] init];
    scrollContain.backgroundColor = [UIColor blackColor];
    [scroll addSubview:scrollContain];
    
    [scrollContain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll).insets(UIEdgeInsetsMake(30, 30, 30, 30));
    }];
    [scrollContain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@1000);
    }];
//    [scrollContain mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(@2000);
//    }];
}


@end
