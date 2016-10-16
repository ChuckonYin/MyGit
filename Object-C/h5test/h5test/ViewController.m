//
//  ViewController.m
//  h5test
//
//  Created by ChuckonYin on 16/5/11.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "H5CameraDelegate.h"
#import "H5WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    H5WebViewController *webCtrl = [[H5WebViewController alloc] initWithUrl:@"http:toapay.com" delegate:[[H5CameraDelegate alloc] init]];
    [self.navigationController pushViewController:webCtrl animated:YES];
    
}


@end
