//
//  ViewController.m
//  16_0308YZTH5WebViewController
//
//  Created by ChuckonYin on 16/3/8.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "YZTH5WebViewController.h"

@interface ViewController ()

@property (nonatomic, strong) H5Service *h5service;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadH5Ctrl)];
    
}

- (void)loadH5Ctrl{
    H5Options *option = [[H5Options alloc] init];
    option.url = @"http://www.cocoachina.com/cms/wap.php";
    self.h5service = [[H5Service alloc] init];
    YZTH5WebViewController *web = [[YZTH5WebViewController alloc] initWithOptions:option delegate:self.h5service];
    [self.navigationController pushViewController:web animated:YES];
}



@end
