//
//  ViewController.m
//  1021copy
//
//  Created by ChuckonYin on 15/10/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYCopyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CYCopyView *view1 = [[CYCopyView alloc] init];
    [self.view addSubview:view1];
    
    CYCopyView *view2 = [view1 copy];
    [self.view addSubview:view2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
