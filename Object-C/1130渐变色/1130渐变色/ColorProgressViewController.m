//
//  ColorProgressViewController.m
//  1130渐变色
//
//  Created by ChuckonYin on 15/12/1.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ColorProgressViewController.h"
#import "CYGradientProgress.h"
@interface ColorProgressViewController ()

@end

@implementation ColorProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CYGradientProgress *p = [[CYGradientProgress alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:p];
}





@end
