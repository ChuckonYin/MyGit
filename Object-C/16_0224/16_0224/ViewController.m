//
//  ViewController.m
//  16_0224
//
//  Created by ChuckonYin on 16/2/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "YZTTitleImageButtun.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    YZTTitleImageButtun *btn = [[YZTTitleImageButtun alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"爱情" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"11.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
     [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 20)];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(40, 40, 0, 0)];
    
//    btn.isImageHidden = YES;
   
//    btn.titleLabel.backgroundColor = [UIColor blackColor];
    
//    btn.titleLabel.frame = CGRectMake(0, 0, 40, 40);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end





