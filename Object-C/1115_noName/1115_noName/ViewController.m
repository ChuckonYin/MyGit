//
//  ViewController.m
//  1115_noName
//
//  Created by ChuckonYin on 15/11/15.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:7];
    [arr addObject:@1];
    [arr addObject:@"one"];
    NSLog(@"%@",arr[1]);
//    arr[3];
    
}


@end
