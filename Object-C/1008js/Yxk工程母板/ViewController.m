//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.baidu.com"]]];
    [self.view addSubview:web];
    
    
}


@end
