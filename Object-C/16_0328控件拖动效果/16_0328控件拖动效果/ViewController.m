//
//  ViewController.m
//  16_0328控件拖动效果
//
//  Created by ChuckonYin on 16/3/28.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYMoveAbleButtun.h"

@interface ViewController ()<CYMoveAbleButtunDelegate>

@property (nonatomic, strong) CYMoveAbleButtun *btn;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.btn = [[CYMoveAbleButtun alloc] init];
    self.btn.frame = CGRectMake(50, 100, 250, 250);
    self.btn.backgroundColor = [UIColor redColor];
    [self.btn addTarget:self action:@selector(act) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    self.btn.delegate = self;
}

- (void)act{
    NSLog(@"8790");
}

- (void)cy_moveAbleButtunDragEnded:(UIControl *)c withEvent:(id)ev{
    NSLog(@"%s", __func__);
}

- (void)cy_moveAbleButtunDragMoving:(UIControl *)c withEvent:(id)ev{
     NSLog(@"%s", __func__);
}

- (void)cy_moveAbleButtunTouchDown:(UIControl *)control withEvent:(id)event{
     NSLog(@"%s", __func__);
}


@end




