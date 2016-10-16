//
//  ViewController.m
//  五维图（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "HealthExamView.h"
#import "TestView.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HealthExamView *view = [[HealthExamView alloc] initWithFrame:CGRectMake(0, 50, 375, 300)];
    [self.view addSubview:view];
    
    [view refreshWithValues:@[@0.5,@0.7,@0.3,@0.9,@1] animate:YES];
    TestView *view1 = [[TestView alloc] init];
    [self.view addSubview:view1];
}


@end
