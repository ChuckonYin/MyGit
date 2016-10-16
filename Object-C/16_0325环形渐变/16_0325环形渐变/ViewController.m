//
//  ViewController.m
//  16_0325环形渐变
//
//  Created by ChuckonYin on 16/3/25.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYGradientView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CYGradientView *view = [[CYGradientView alloc] initWithFrame:CGRectMake(50, 100, 280, 400)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    
    
}


@end
