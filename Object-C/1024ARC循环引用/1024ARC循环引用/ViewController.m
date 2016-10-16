//
//  ViewController.m
//  1024ARC循环引用
//
//  Created by ChuckonYin on 15/10/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"

@interface ViewController ()<FirstViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FirstViewController *vc = [[FirstViewController alloc] init];
    
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)FirstViewControllerAct
{
    NSLog(@"代理执行");
}
f  nnn nn  n  n        


@end
