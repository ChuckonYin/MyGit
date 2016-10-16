//
//  ViewController.m
//  YZTProgressButtun
//
//  Created by ChuckonYin on 16/4/22.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "YZTProgressButtun.h"

@interface ViewController ()

@property (nonatomic, strong) YZTProgressButtun *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.btn];
    NSLog(@"%@", [NSDate date]);
    [self.btn startWithTimeInterval:2 clickAction:^{
        NSLog(@"click");
    } endAction:^{
        NSLog(@"end");
        NSLog(@"%@", [NSDate date]);
    }];
    
}

- (YZTProgressButtun *)btn{
    if (!_btn) {
        _btn = [[YZTProgressButtun alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    }
    return _btn;
}


@end
