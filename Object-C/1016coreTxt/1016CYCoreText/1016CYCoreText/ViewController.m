//
//  ViewController.m
//  1016CYCoreText
//
//  Created by ChuckonYin on 15/10/16.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYCoretextView.h"

@interface ViewController ()

@property(nonatomic, strong) CYCoretextView *coreTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreTextView = [[CYCoretextView alloc] initWithFrame:CGRectMake(50, 100, 250, 300)];
    
    _coreTextView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_coreTextView];
    
}

@end
