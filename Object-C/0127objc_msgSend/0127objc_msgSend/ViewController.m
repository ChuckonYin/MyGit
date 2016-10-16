//
//  ViewController.m
//  0127objc_msgSend
//
//  Created by ChuckonYin on 16/1/27.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:btn];
    SEL sel = @selector(btnClick:);
    NSLog(@"%s", (char*)sel);
    btn.backgroundColor = [UIColor redColor];
    
    //编译时不知方法地址，运行时获取地址并缓存方法地址。略慢于function call
    objc_msgSend(self, sel, btn);
    
//    NSLog(@"%@", objc_msgSend(self, sel, point));
    
    
}

- (void)btnClick:(UIButton*)sender
{
    NSLog(@"点击");
}



@end
