//
//  ViewController.m
//  16_0315block的引用计数器
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

typedef void(^Block)();

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     Shop *shop = [Shop new];
    
    Block block = ^{
//        self;
        shop;
    };
    
//    block = nil;
    
//    self = nil;
    
    NSLog(@"%li", CFGetRetainCount((__bridge CFTypeRef)(shop)));
    
}

@end

@implementation Shop

@end
