//
//  ViewController.m
//  lzg按钮
//
//  Created by ChuckonYin on 15/10/26.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYAdScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CYAdScrollView *adView = [[CYAdScrollView alloc] initWithFrame:CGRectMake(50, 100, 200, 300) inteval:2 clickIndex:^(NSInteger clickIndex) {
        
    }];
    adView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:adView];
    
    [adView refrehAdViewwith:@[@"444.jpg",@"444.jpg",@"444.jpg",@"444.jpg"]];
}


@end
