//
//  MoreViewController.m
//  pageViewControllow
//
//  Created by 刘志刚 on 16/5/25.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _myWebView.backgroundColor=[UIColor redColor];
}

- (void) viewWillAppear:(BOOL)paramAnimated
{
    [super viewWillAppear:paramAnimated];
    [self.myWebView loadHTMLString:_dataObject baseURL:nil];
    [self.view addSubview:self.myWebView];
    
}

@end
